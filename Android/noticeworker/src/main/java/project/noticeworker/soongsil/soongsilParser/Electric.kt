package project.noticeworker.soongsil.soongsilParser

import org.jsoup.Jsoup
import project.noticeworker.base.Major
import project.noticeworker.base.Notice
import java.net.URLEncoder

class Electric : Major("전자정보공학부", "School of Electronic Engineering") {
    override fun getURL(page: Int, keyword: String?): String {
        val noticeUrl = "http://infocom.ssu.ac.kr/rb/?c=2/38&p=$page"
        val resultURL: String

        resultURL = if (keyword != null) {
            val keywordSearch = URLEncoder.encode(keyword, "UTF-8")
            val searchUrl = "http://infocom.ssu.ac.kr/rb/?c=2/38&where=subject%7Ctag&keyword=$keywordSearch&p=$page"
            searchUrl
        } else {
            noticeUrl
        }

        return resultURL
    }

    override fun parse(html: String) : ArrayList<Notice>{
        var noticeList : ArrayList<Notice> = ArrayList()
        val doc = Jsoup.parse(html)
        for (product in doc.select("div[class^='list']")) {
            var url = product.attr("href") ?: ""
            url = url.replace("..", "https://sw.ssu.ac.kr")

            val strs = (product.select("div[class^='info']").first()?.text() ?: "").split("|")

            val author = strs[0].trim()
            val dateString = strs[1].trim()

            val title = if(product.select("span[class^='subject']").first().text() == ""){
                "(제목없음)"
            } else{
                product.select("span[class^='subject']").first().text()
            }

            val isNotice = product.html().contains("img")

            noticeList.add(Notice(author,title,url, dateString, isNotice))
        }
        return noticeList
    }
}