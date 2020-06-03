package project.noticeworker.base

import project.noticeworker.soongsil.soongsilParser.Software

class Depertment(var DeptName : String){
    val majorList : ArrayList<in Major> = ArrayList()

    fun addMajor(tmp: Major){
        majorList.add(tmp)
    }

    fun getMajorCnt() : Int { return majorList.size; }
}
