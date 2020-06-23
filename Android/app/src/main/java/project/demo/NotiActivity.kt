package project.demo

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.android.synthetic.main.activity_major_noti.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import project.noticeworker.base.Notice



class NotiActivity : AppCompatActivity() {
    private var isLast: Boolean = false
    private var result: ArrayList<Notice> = ArrayList()
    private var notiList: ArrayList<Notice> = ArrayList()
    private var resultTrigger: Notice? = null
    private lateinit var mAdapter: NoticeAdapter

    private val complete = { noticeList: ArrayList<Notice> ->
        if (resultTrigger != null && noticeList.size > 0) {
            if (resultTrigger?.url == noticeList[0].url) isLast = true
            else resultTrigger = noticeList[0]
        } else if (resultTrigger == null && noticeList.size > 0) resultTrigger = noticeList[0]
        result = noticeList
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_major_noti)
        result = intent.getParcelableArrayListExtra<Notice>("list")
        CoroutineScope(Dispatchers.Main).launch {
            // Show progress from UI thread
            withContext(CoroutineScope(Dispatchers.Default).coroutineContext) {
                // background thread
            }
            update()
        }
        mAdapter = NoticeAdapter(mArticleDiffCallback, notiList, clicked = clicked)
        val layoutManager = LinearLayoutManager(this)
        notiListRecycler.adapter = mAdapter
        notiListRecycler.layoutManager = layoutManager
    }


    private fun update() {
        if (!isLast) {
            notiList.addAll(result)
            mAdapter.submitList(notiList)
            mAdapter.notifyDataSetChanged()
        }
    }

    private val mArticleDiffCallback = object : DiffUtil.ItemCallback<Notice>() {
        override fun areItemsTheSame(oldItem: Notice, newItem: Notice): Boolean {
            return oldItem.title == newItem.title
        }

        override fun areContentsTheSame(oldItem: Notice, newItem: Notice): Boolean {
            return (oldItem.title == newItem.title) && (oldItem.url == newItem.url)
        }
    }


    private val clicked = { title: String?, date: String?, url: String? ->
        //val intent = Intent(activity, NotiDetailActivity::class.java)
        /*      intent.putExtra(TITLE_INTENT_KEY, title)
              intent.putExtra(DATE_INTENT_KEY, date)
              intent.putExtra(URL_INTENT_KEY, url)
              intent.putExtra(MAJOR_INTENT_KEY, majorNumber)*/
        startActivity(intent)
    }
}