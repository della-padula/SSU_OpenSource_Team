package project.noticeworker.soongsil

import project.noticeworker.NoticeSSUCatch
import project.noticeworker.soongsil.soongsilParser.*
import project.noticeworker.base.Depertment
import project.noticeworker.base.Notice
import project.noticeworker.base.Organization

class SSU : Organization() {
    enum class Dept(val eng: String, val kor: String) {
        IT("IT", "IT대학"),
        Law("Law","법과대학"),
        Human("Humanities","인문대학"),
        Engineer("Engineering","공과대학"),
        Science("NaturalSciences","자연과학대학"),
        Biz("BusinessAdministration","경영대학"),
        Economic("EconomicCommerce","경제통상대학"),
        Social("SocialSciences","사회과학대학"),
        Cover("Convergence","융합특성화자유전공학부")
    }


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
            if(deptName == department.DeptName)
                return department.majorList.map{t->t.name}
        }
        return null
    }

    fun loadMajor(deptName : String) {
        when (deptName) {
            "IT" -> {
                Depertments.get(0).addMajor(0, "컴퓨터학부", "CSE")
                Depertments.get(0).addMajor(1, "글로벌미디어학부", "The Global School of Media")
                Depertments.get(0).addMajor(2, "스마트시스템소프트웨어학과", "School of Electronic Engineering")
                Depertments.get(0).addMajor(3, "IT융합전공", "School of Software")
                Depertments.get(0).addMajor(4, "전자정보공학부", "Smart Systems Software")
                Depertments.get(0).addMajor(5, "소프트웨어학부", "School of Software")
                Depertments.get(0).addMajor(6, "미디어경영학과", "Smart Systems Software")
            }
            "Law" -> {
                Depertments.get(1).addMajor(0, "법학과", "CSE")
                Depertments.get(1).addMajor(1, "국제법무학과", "The Global School of Media")
            }
            "Humanities" -> {
                Depertments.get(2).addMajor(0, "기독교학과", "Korean Language & Literature")
                Depertments.get(2).addMajor(1, "영어영문학과", "The Global School of Media")
                Depertments.get(2).addMajor(2, "불어불문학과", "School of Electronic Engineering")
                Depertments.get(2).addMajor(3, "일어일문학과", "School of Software")
                Depertments.get(2).addMajor(4, "사학과", "Smart Systems Software")
                Depertments.get(2).addMajor(5, "스포츠학부", "Smart Systems Software")
                Depertments.get(2).addMajor(6, "국어국문학과", "Smart Systems Software")
                Depertments.get(2).addMajor(7, "독어독문학과", "Smart Systems Software")
                Depertments.get(2).addMajor(8, "중어중문학과", "Smart Systems Software")
                Depertments.get(2).addMajor(9, "철학과", "Smart Systems Software")
                Depertments.get(2).addMajor(10, "예술창작부", "Smart Systems Software")
            }
            "Engineering" -> {
                Depertments.get(3).addMajor(0, "화학공학과", "Korean Language & Literature")
                Depertments.get(3).addMajor(1, "전기공학과", "The Global School of Media")
                Depertments.get(3).addMajor(2, "건축학부", "The Global School of Media")
                Depertments.get(3).addMajor(3, "산업·정보시스템공학과", "School of Electronic Engineering")
                Depertments.get(3).addMajor(4, "기계공학부", "School of Software")
                Depertments.get(3).addMajor(5, "유기신소재·파이버공학과", "Smart Systems Software")
            }
            "NaturalSciences" -> {
                Depertments.get(4).addMajor(0, "수학과", "Korean Language & Literature")
                Depertments.get(4).addMajor(1, "화학과", "The Global School of Media")
                Depertments.get(4).addMajor(2, "의생명시스템학부", "School of Electronic Engineering")
                Depertments.get(4).addMajor(3, "물리학과", "School of Software")
                Depertments.get(4).addMajor(4, "정보통계·보험수리학과", "Smart Systems Software")
            }
            "BusinessAdministration" -> {
                Depertments.get(5).addMajor(0, "경영학부", "Korean Language & Literature")
                Depertments.get(5).addMajor(1, "회계학과", "The Global School of Media")
                Depertments.get(5).addMajor(2, "벤처경영학과", "School of Electronic Engineering")
                Depertments.get(5).addMajor(3, "복지경영학과", "School of Software")
                Depertments.get(5).addMajor(4, "벤처중소기업학과", "The Global School of Media")
                Depertments.get(5).addMajor(5, "금융학부", "School of Electronic Engineering")
                Depertments.get(5).addMajor(6, "혁신경영학과", "School of Software")

            }
            "EconomicCommerce" -> {
                Depertments.get(6).addMajor(0, "경제학부", "Korean Language & Literature")
                Depertments.get(6).addMajor(1, "금융경제학과", "The Global School of Media")
                Depertments.get(6).addMajor(2, "글로벌통상학과", "Korean Language & Literature")
                Depertments.get(6).addMajor(3, "국제무역학과", "The Global School of Media")

            }
            "SocialSciences" -> {
                Depertments.get(7).addMajor(0, "사회복지학부", "Korean Language & Literature")
                Depertments.get(7).addMajor(1, "정치외교학부", "The Global School of Media")
                Depertments.get(7).addMajor(2, "언론홍보학과", "School of Electronic Engineering")
                Depertments.get(7).addMajor(3, "행정학부", "Korean Language & Literature")
                Depertments.get(7).addMajor(4, "정보사회학과", "The Global School of Media")
                Depertments.get(7).addMajor(5, "평생교육학과", "School of Electronic Engineering")
            }
            "Convergence" -> {
                Depertments.get(8).addMajor(0, "융합특성화자유전공학부", "Korean Language & Literature")
            }
        }
    }

    companion object {

        open fun loadNoti(deptNumber: Int, majorNumber:Int , page: Int, keyword: String?, complete: (ArrayList<Notice>) -> Unit) {
            when (deptNumber) {
                -1 -> {
                    NoticeSSUCatch.parseListSSUCatch(page = page, keyword = keyword, completion = complete) }
                0 -> {
                    when(majorNumber) {
                        0 -> {
                            NoticeIT.parseListComputer(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        1 -> {
                            NoticeIT.parseListMedia(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        2 -> {
                            NoticeIT.parseListSmartSystem(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        4 -> {
                            NoticeIT.parseListElectric(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        5 -> {
                            NoticeIT.parseListSoftware(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }

                    }
                }
                1 -> {
                    when (majorNumber) {
                        0 -> {
                            NoticeLaw.parseListLaw(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        1 -> {
                            NoticeLaw.parseListIntlLaw(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                    }
                }
                2 -> {
                    when (majorNumber) {
                        1 -> {
                            NoticeHuman.parseListEnglish(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        2 -> {
                            NoticeHuman.parseListFrench(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        3 -> {
                            NoticeHuman.parseListJapanese(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        4 -> {
                            NoticeHuman.parseListHistory(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        // 스포츠학부
                        6 -> {
                            NoticeHuman.parseListKorean(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        7 -> {
                            NoticeHuman.parseListGerman(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        8 -> {
                            NoticeHuman.parseListChinese(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        9 -> {
                            NoticeHuman.parseListPhilo(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        10 -> {
                            NoticeHuman.parseListWriting(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                    }
                }
                3 -> {
                    when (majorNumber) {
                        0 -> {
                            NoticeEngineer.parseListChemistryEngineering(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        1 -> {
                            NoticeEngineer.parseListElectric(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        2 -> {
                            NoticeEngineer.parseListArchitecture(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        3 -> {
                            NoticeEngineer.parseListIndustry(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        4 -> {
                            NoticeEngineer.parseListMachine(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        5 -> {
                            NoticeEngineer.parseListOrganic(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                    }
                }
                4 -> {
                    when (majorNumber) {
                        0 -> {
                            NoticeScience.parseListMath(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        1 -> {
                            NoticeScience.parseListChemistry(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        2 -> {
                            NoticeScience.parseListBiomedical(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        3 -> {
                            NoticeScience.parseListPhysics(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        4 -> {
                            NoticeScience.parseListActuarial(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                    }
                }
                5 -> {
                    when (majorNumber) {
                        0 -> {
                            NoticeBusiness.parseListBiz(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        1 -> {
                            NoticeBusiness.parseListVenture(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        2 -> {
                            NoticeBusiness.parseListAccount(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        3 -> {
                            NoticeBusiness.parseListFinance(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                    }
                }
                6 -> {
                    when (majorNumber) {
                        0 -> {
                            NoticeEconomy.parseListEconomics(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        1 -> {
                            NoticeEconomy.parseListGlobalCommerce(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }

                    }
                }
                7 -> {
                    when (majorNumber) {
                        0 -> {
                            NoticeSocial.parseListWelfare(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        1 -> {
                            NoticeSocial.parseListPolitical(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        2 -> {
                            NoticeSocial.parseListJournalism(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        3 -> {
                            NoticeSocial.parseListAdministration(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                        4 -> {
                            NoticeSocial.parseListSociology(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }

                        5 -> {
                            NoticeSocial.parseListLifeLong(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }

                    }
                }
                8 -> {
                    when (majorNumber) {
                        0 -> {
                            NoticeConvergence.parseListConvergence(
                                page = page,
                                keyword = keyword,
                                completion = complete
                            )
                        }
                    }
                }
            }
        }
    }
}