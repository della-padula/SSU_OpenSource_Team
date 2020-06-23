package project.noticeworker.soongsil.soongsilParser

import android.util.Log
import org.jsoup.Jsoup
import project.noticeworker.base.Major
import project.noticeworker.base.Notice
import java.net.URLEncoder

class SSU_Software : Major("소프트웨어학부", "School of Software") {
    override fun getURL(page: Int, keyword: String?): String {
        val noticeUrl = "https://sw.ssu.ac.kr/bbs/board.php?bo_table=sub6_1&page=$page"
        val resultURL: String

        resultURL = if (keyword != null) {
            val keywordSearch = URLEncoder.encode(keyword, "UTF-8")
            val searchUrl = "https://sw.ssu.ac.kr/bbs/board.php?bo_table=sub6_1&sca=&stx=$keywordSearch&sop=and&page=$page"
            searchUrl
        } else {
            noticeUrl
        }
        return resultURL
    }

    override fun parse(html: String) : ArrayList<Notice>{
        val doc = Jsoup.parse(html)
        val authorList = ArrayList<String>()
        val titleList  = ArrayList<String>()
        val urlList = ArrayList<String>()
        val dateStringList = ArrayList<String>()
        val isNoticeList = ArrayList<Boolean>()
        var noticeList : ArrayList<Notice> = ArrayList()

        var index: Int = 0

        for (product in doc.select("td[class^=num]")) {
            val num = product.select("b").first()?.text() ?: ""
            isNoticeList.add(num.isNotEmpty())
        }

        val subject = doc.select("td[class^=subject]")
        for (product in subject.select("a")) {
            var url = product.attr("href") ?: ""
            url = url.replace("..", "https://sw.ssu.ac.kr")
            titleList.add(product.text() ?: "")
            urlList.add(url)
        }

        for (product in doc.select("td[class^=datetime]")) {
            dateStringList.add(product.text() ?: "")
        }

        for (product in doc.select("td[class^=name]")) {
            authorList.add(product.text() ?: "")
        }

        for (num in authorList) {
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