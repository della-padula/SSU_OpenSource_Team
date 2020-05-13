package com.denny.noticeworker.Base

class Depertment(var DeptName : String){
    val majorList = ArrayList<Major>()

    fun addMajor(id : Int, name : String , URL : String){
       majorList.add(Major(id, name, URL))
    }

    fun getMajorCnt() : Int { return majorList.size; }
}
