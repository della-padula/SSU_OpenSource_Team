package project.noticeworker.soongsil.soongsilParser

import org.jsoup.Jsoup
import project.noticeworker.base.Major
import project.noticeworker.base.Notice
import java.net.URLEncoder

class SSU_SmartSystem : Major("스마트시스템소프트웨어학과", "Smart System Software") {
    override fun getURL(page: Int, keyword: String?): String {
        val noticeUrl = "http://smartsw.ssu.ac.kr/board/notice/$page"

        val resultURL: String
        resultURL = if (keyword != null) {
            val keywordSearch = URLEncoder.encode(keyword, "UTF-8")
            val searchUrl = "http://smartsw.ssu.ac.kr/board/notice/$page?search=$keywordSearch"
            searchUrl
        } else {
            noticeUrl
        }

        return resultURL
    }

    override fun parse(html: String) : ArrayList<Notice>{
        var noticeList : ArrayList<Notice> = ArrayList()
        val doc = Jsoup.parse(html)

        var index  = 0
        for (product in doc.select("table[class='ui celled padded table'] tbody td")) {
            val content = (product.text() ?: "").trim()
            val noticeItem : Notice
            var title : String =""
            var author : String = ""
            var date : String = ""
            when(index % 4) {
                0 -> {
                   title = content
                }
                1 -> {
                    author = content
                }
                2 -> {
                    date = content
                }
                else -> {}
            }

            val url = product.select("a").first()
            if (url != null) {
                val realUrl = "http://smartsw.ssu.ac.kr${url.attr("href")}"
                noticeItem = Notice(author,title,realUrl,date,false)
                noticeList.add(noticeItem)
            }
        }
        return noticeList
    }
}