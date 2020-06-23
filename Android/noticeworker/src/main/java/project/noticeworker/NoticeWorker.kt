package project.noticeworker

import project.noticeworker.base.Major
import project.noticeworker.base.Organization
import project.noticeworker.seoulnational.SeoulNational
import project.noticeworker.soongsil.Soongsil

object NoticeWorker {
    private val Organizations : ArrayList<in Organization> = ArrayList(
        listOf(
          Soongsil(), SeoulNational()
        ))

    fun define(str : String) : Organization{
        when(str) {
            "숭실대학교"-> {
                return NoticeWorker.Organizations[0] as Soongsil
            }
            "서울대학교"-> {
                return NoticeWorker.Organizations[1] as SeoulNational
            }
        }
        return Organization("Error")
    }

    fun getOrganizationList() : List<String>{
        val tmp = Organizations as ArrayList<Organization>
        return tmp.map{ t -> t.name }
    }
}


