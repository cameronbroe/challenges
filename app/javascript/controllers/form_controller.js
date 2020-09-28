import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ "fileInput", "fileName" ]

    handleFileSelect() {
        if(this.fileInputTarget.files.length > 0) {
            this.fileNameTarget.textContent = this.fileInputTarget.files[0].name
        } else {
            this.fileNameTarget.textContent = "No file uploaded"
        }
    }

    uploadData() {
        console.log('Submitted form')
    }

    clearFileInput() {
        this.fileInputTarget.value = ""
        this.handleFileSelect()
    }
}
