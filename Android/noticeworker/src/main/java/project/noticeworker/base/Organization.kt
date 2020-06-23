package project.noticeworker.base

import kotlin.collections.ArrayList

open class Organization(val name : String){
    open fun getDeptList() : List<String>?{
        return ArrayList()
    }

    open fun loadMajor(s: String) {

    }
    open fun getMajorList(deptName: String): List<String>? {
        TODO("Not yet implemented")
    }
    open fun getMajor(dept : Int, major:Int) :Major{
        TODO("Not yet implemented")
    }
}