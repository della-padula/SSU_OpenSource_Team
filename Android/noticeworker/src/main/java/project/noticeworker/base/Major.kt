package project.noticeworker.base

import org.w3c.dom.Document


open class Major(kor: String, eng: String) {
    var kor: String = kor
    var eng: String = eng

    open fun getURL(page: Int, keyword: String?): String{
        return ""
    }
    open fun parse(html: String) : ArrayList<Notice> {
        return ArrayList()
    }
}