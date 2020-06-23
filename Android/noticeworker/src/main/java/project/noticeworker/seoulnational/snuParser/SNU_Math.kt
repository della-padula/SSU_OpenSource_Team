package project.noticeworker.seoulnational.snuParser

import org.jsoup.Jsoup
import project.noticeworker.base.Major
import project.noticeworker.base.Notice
import project.noticeworker.isNumeric
import java.net.URLEncoder

class SNU_Math : Major("수리과학부", "Department of Mathematical Sciences") {

    override fun getURL(page: Int, keyword: String?): String {
        val noticeUrl = "http://www.math.snu.ac.kr/board/index.php?mid=notice&page=$page"
        val resultURL: String
        resultURL = if (keyword != null) {
            val keywordSearch = URLEncoder.encode(keyword, "UTF-8")
            val searchUrl = "http://www.math.snu.ac.kr/board/?_filter=search&act=&mid=notice&category=&search_target=title_content&search_keyword=$keywordSearch"
            searchUrl
        } else {
            noticeUrl
        }
        return resultURL
    }

    override fun parse(html: String) : ArrayList<Notice> {
        val doc = Jsoup.parse(html)
        var noticeList: ArrayList<Notice> = ArrayList()
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
                        url = "http://www.math.snu.ac.kr/${td.select("a").attr("href")}"
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
