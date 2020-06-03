package project.noticeworker.soongsil

import android.util.Log
import project.noticeworker.NoticeSSUCatch
import project.noticeworker.soongsil.soongsilParser.*
import project.noticeworker.base.Depertment
import project.noticeworker.base.Major
import project.noticeworker.base.Notice
import project.noticeworker.base.Organization

object SSU : Organization() {
    val Depertments = ArrayList<Depertment>(
        listOf(
            Depertment("IT"),
            Depertment("Law"),
            Depertment("Humanities"),
            Depertment("Engineering"),
            Depertment("NaturalSciences"),
            Depertment("BusinessAdministration"),
            Depertment("EconomicCommerce"),
            Depertment("SocialSciences"),
            Depertment("Convergence")
        ))

    open fun getDeptList() : List<String>{
        return Depertments.map{t->t.DeptName}
    }
    open fun getMajorList(deptName : String) : List<String>? {
        for(department in Depertments){
            if(deptName == department.DeptName) {
                val tmp = department.majorList as ArrayList<Major>
                return tmp.map{ t -> t.kor }
            }
        }
        return null
    }

    fun loadMajor(deptName : String) {
        when (deptName) {
            "IT" -> {
                if(Depertments[0].getMajorCnt()==0) {
                    Depertments[0].addMajor(Software())
                    Depertments[0].addMajor(Electric())
                    Depertments[0].addMajor(Computer())
                }
            }
            "Law" -> {

            }
            "Humanities" -> {

            }
            "Engineering" -> {

            }
            "NaturalSciences" -> {

            }
            "BusinessAdministration" -> {

            }
            "EconomicCommerce" -> {

            }
            "SocialSciences" -> {

            }
            "Convergence" -> {

            }
        }

    }
}