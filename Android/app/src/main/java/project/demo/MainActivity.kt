package project.demo

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.coroutines.*
import org.jsoup.Jsoup
import project.noticeworker.NoticeWorker
import project.noticeworker.base.Notice
import project.noticeworker.base.Organization


class MainActivity : AppCompatActivity() {
    private var organization :Int = 0
    private var deptNumber: Int = 0
    private var majorNumber: Int = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        val orgMap = NoticeWorker.getOrganizationList()
        val orgAdpater = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, orgMap)
        orgSpin.adapter = orgAdpater
        orgSpin.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>, view: View, position: Int, id: Long) {
                organization = position
            }
            override fun onNothingSelected(parent: AdapterView<*>) {
            }
        }
        lateinit var tmp : Organization

        var deptMap : List<String>
        startOrg.setOnClickListener {
            tmp =  NoticeWorker.define(orgMap[organization])
            deptMap = tmp.getDeptList()!!

            val deptAdapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, deptMap)
            deptSpin.adapter = deptAdapter
            deptSpin.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                override fun onItemSelected(parent: AdapterView<*>, view: View, position: Int, id: Long) {
                    deptNumber = position
                }
                override fun onNothingSelected(parent: AdapterView<*>) {
                }
            }
        }

        var majorMap : List<String>
        startDept.setOnClickListener {
            (tmp.getDeptList()?.get(deptNumber))?.let { it1 -> tmp.loadMajor(it1) }
            // 학과 호출
            majorMap = tmp.getDeptList()?.get(deptNumber)?.let { it1 -> tmp.getMajorList(it1) }!!
            val majorAdapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, majorMap)
            majorSpin.adapter = majorAdapter
            majorSpin.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                override fun onItemSelected(parent: AdapterView<*>, view: View, position: Int, id: Long) {
                    majorNumber = position
                }
                override fun onNothingSelected(parent: AdapterView<*>) {

                }
            }
        }

        var result : ArrayList<Notice> = ArrayList<Notice>()
        startMajor.setOnClickListener {
            val intent = Intent(this, NotiActivity::class.java)
            val url = tmp.getMajor(deptNumber,majorNumber).getURL(1,"")
            val cor = CoroutineScope(Dispatchers.Main).launch {
                // Show progress from UI thread
                withContext(CoroutineScope(Dispatchers.Default).coroutineContext) {
                    // background thread
                    try {
                        val html = Jsoup.connect(url).get().html()
                        result =  tmp.getMajor(deptNumber,majorNumber).parse(html)
                        intent.putParcelableArrayListExtra("list", result)
                        intent.putExtra("major", majorNumber)
                        startActivity(intent)

                    } catch (ex: Exception) {
                        Log.e("ERROR", "io")
                    }
                }
            }
        }
    }


}
