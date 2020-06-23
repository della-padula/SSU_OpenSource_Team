package project.noticeworker.seoulnational.snuParser
import android.util.Log
import org.jsoup.Jsoup
import project.noticeworker.base.Major
import project.noticeworker.base.Notice
import project.noticeworker.isNumeric
import java.lang.Exception
import java.net.URLEncoder

class SNU_Physics : Major("물리＆천문학부(물리학전공)", "Depertment of Physics & Astronomy (Physics)") {
    override fun getURL(page: Int, keyword: String?): String {
        val noticeUrl = "https://physics.snu.ac.kr/boards/notice?page=$page"
        val resultURL : String

        resultURL = if (keyword != null) {
            val keywordSearch = URLEncoder.encode(keyword, "UTF-8")
            val searchUrl = "https://physics.snu.ac.kr/boards/notice?qt=t&q=$keywordSearch"
            searchUrl
        } else {
            noticeUrl
        }
        return resultURL
    }

    override fun parse(html: String) : ArrayList<Notice>{
        val doc = Jsoup.parse(html)
        val noticeList : ArrayList<Notice> = ArrayList()

        for (product in doc.select("tbody tr")) {

            val tds = product.select("td")
            var tdIndex = 0
            var isNotice = false
            var title = ""
            var author = ""
            var date = ""
            var url = ""
            for (td in tds) {
                when (tdIndex) {
                    0 -> {
                        isNotice = !td.text().isNumeric()
                    }
                    1 -> {
                        title = td.select("a").text()
                        url = "https://physics.snu.ac.kr/${td.select("a").attr("href")}"
                        Log.d("Test",url)
                    }
                    2 -> {
                        date = td.text()
                    }
                    3 -> {

                    }
                    else -> {
                    }
                }
                tdIndex += 1
            }
            if (title.isNotEmpty() && date.isNotEmpty() && url.isNotEmpty())
                noticeList.add(Notice(author, title, url, date, isNotice))
        }

        return noticeList
    }
}