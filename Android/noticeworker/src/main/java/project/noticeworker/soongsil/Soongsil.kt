package project.noticeworker.soongsil

import project.noticeworker.soongsil.soongsilParser.*
import project.noticeworker.base.Depertment
import project.noticeworker.base.Major
import project.noticeworker.base.Organization

class Soongsil : Organization("숭실대학교") {
    private val Depertments = ArrayList<Depertment>(
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

    override fun getDeptList() : List<String>{
        return Depertments.map{t->t.DeptName}
    }

    override fun getMajorList(deptName : String) : List<String>? {
        for(department in Depertments){
            if(deptName == department.DeptName) {
                val tmp = department.majorList as ArrayList<Major>
                return tmp.map{ t -> t.kor }
            }
        }
        return null
    }
    override fun getMajor(dept : Int, major:Int) :Major {
        return Depertments[dept].getMajor(major) as Major
    }
    override fun loadMajor(deptName : String) {
        when (deptName) {
            "IT" -> {
                if(Depertments[0].getMajorCnt()==0) {
                    Depertments[0].addMajor(SSU_Software())
                    Depertments[0].addMajor(SSU_Electric())
                    Depertments[0].addMajor(SSU_Computer())
                    Depertments[0].addMajor(SSU_Media())
                    Depertments[0].addMajor(SSU_SmartSystem())
                }
            }
            "Law" -> {
                if(Depertments[1].getMajorCnt()==0) {
                    Depertments[1].addMajor(SSU_Law())
                    Depertments[1].addMajor(SSU_IntLaw())
                }
            }
            "Humanities" -> {
                if(Depertments[2].getMajorCnt()==0) {
                    Depertments[2].addMajor(SSU_Korlan())
                    Depertments[2].addMajor(SSU_Englan())
                    Depertments[2].addMajor(SSU_Germlan())
                }
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