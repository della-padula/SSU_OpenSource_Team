package project.noticeworker.soongsil.soongsilParser
import org.jsoup.Jsoup
import project.noticeworker.base.Major
import project.noticeworker.base.Notice
import project.noticeworker.isNumeric
import java.net.URLEncoder

class SSU_Law : Major("법학과", "School of Law") {
    override fun getURL(page: Int, keyword: String?): String {

        val noticeUrl = "http://law.ssu.ac.kr/web/law/board1?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage=$page"

        val resultURL: String
        resultURL = if (keyword != null) {
            val keywordSearch = URLEncoder.encode(keyword, "UTF-8")
            val searchUrl = "http://law.ssu.ac.kr/web/law/board1?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=$keywordSearch&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=$keywordSearch&_EXT_BBS_curPage=$page"
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
                        isNotice =   !td.text().isNumeric()
                    }
                    1 -> {
                        title = td.select("a").text()
                        url = "${td.select("a").attr("href")}"
                    }
                    2 -> {
                        author = ""
                    }
                    3 -> {
                        date = td.text()
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