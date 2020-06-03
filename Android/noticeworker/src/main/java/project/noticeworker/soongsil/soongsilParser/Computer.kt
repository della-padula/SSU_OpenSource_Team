package project.noticeworker.soongsil.soongsilParser
import org.jsoup.Jsoup
import project.noticeworker.base.Major
import project.noticeworker.base.Notice
import project.noticeworker.isNumeric
import java.lang.Exception
import java.net.URLEncoder

class Computer : Major("컴퓨터학부", "CSE") {
    override fun getURL(page: Int, keyword: String?): String {

        val noticeUrl = "http://cse.ssu.ac.kr/03_sub/01_sub.htm?page=$page&key=&keyfield=&category=&bbs_code=Ti_BBS_1"
        val resultURL: String

        resultURL = if (keyword != null) {
            val keywordSearch = URLEncoder.encode(keyword, "UTF-8")
            val searchUrl = "http://cse.ssu.ac.kr/03_sub/01_sub.htm?page=$page&key=$keywordSearch&keyfield=subject&category=&bbs_code=Ti_BBS_1"

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
                        url = "http://cse.ssu.ac.kr/03_sub/01_sub.htm${td.select("a").attr("href")}"
                    }
                    2 -> {
                        author = td.text()
                    }
                    3 -> {
                        date = td.text()
                    }
                    else -> {
                    }
                }
                tdIndex += 1
            }
            if (author.isNotEmpty() && title.isNotEmpty() && date.isNotEmpty() && url.isNotEmpty())
                noticeList.add(Notice(author, title, url, date, isNotice))
        }

        return noticeList
    }
}