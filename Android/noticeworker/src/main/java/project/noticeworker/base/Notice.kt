package project.noticeworker.base

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Notice (val author: String?,
              val title: String?,
              val url: String?,
              val date: String?,
              val isNotice: Boolean?) : Parcelable {}
