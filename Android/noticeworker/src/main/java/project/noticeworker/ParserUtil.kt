package project.noticeworker

fun String.isNumeric() : Boolean {
    return this.toDoubleOrNull() != null
}
