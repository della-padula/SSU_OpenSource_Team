package project.noticeworker.soongsil.soongsilParser
import org.jsoup.Jsoup
import project.noticeworker.base.Major
import project.noticeworker.base.Notice
import project.noticeworker.isNumeric
import java.lang.Exception
import java.net.URLEncoder

class SSU_Media : Major("글로벌미디어학부" , "Global School of Media") {
    override fun getURL(page: Int, keyword: String?): String {
        val noticeUrl = "http://media.ssu.ac.kr/sub.php?code=XxH00AXY&mode=&category=1&searchType=&search=&orderType=&orderBy=&page=$page"
        val resultURL : String
        resultURL = if (keyword != null) {
            val keywordSearch = URLEncoder.encode(keyword, "UTF-8")
            val searchUrl = "http://media.ssu.ac.kr/sub.php?code=XxH00AXY&mode=&category=1&searchType=title&search=$keywordSearch&orderType=&orderBy=&page=$page"
            searchUrl
        } else {
            noticeUrl
        }

        return resultURL
    }

    override fun parse(html: String) : ArrayList<Notice>{
        val noticeList = ArrayList<Notice>()
        val authorList = ArrayList<String>()
        val titleList  = ArrayList<String>()
        val urlList = ArrayList<String>()
        val dateStringList = ArrayList<String>()
        val isNoticeList = ArrayList<Boolean>()

        val doc = Jsoup.parse(html)

        for (product in doc.select("table tbody tr a")) {
            val noticeIdText = product.attr("onclick")
            val noticeId = noticeIdText.split("'")[1]
            val url =
                "http://media.ssu.ac.kr/sub.php?code=XxH00AXY&mode=view&board_num=$noticeId&category=1"
            urlList.add(url)
            titleList.add(product.text() ?: "")
        }

        var index = 0
        index = 0
        for (product in doc.select("td[align='center']")) {
            if (index % 4 == 0) {
                val isNotice = product.text() ?: ""
                if (!isNotice.isNumeric()) {
                    isNoticeList.add(true)
                } else {
                    isNoticeList.add(false)
                }
            }

            if (index % 4 == 1) {
                authorList.add(product.text() ?: "")
            } else if (index % 4 == 2) {
                dateStringList.add(product.text() ?: "")
            }
            index += 1
        }

        index=0
        for (x in authorList) {
            val noticeItem = Notice(
                authorList[index],
                titleList[index],
                urlList[index],
                dateStringList[index],
                isNoticeList[index]
            )
            noticeList.add(noticeItem)
            index += 1
        }
        return noticeList
    }
}