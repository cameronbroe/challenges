import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [
        "fileInput",
        "fileName",
        "successMessage",
        "errorMessage",
        "successMessageContents",
        "errorMessageContents",
        "messagesSection",
        "authenticityToken"
    ]

    handleFileSelect() {
        if(this.fileInputTarget.files.length > 0) {
            this.fileNameTarget.textContent = this.fileInputTarget.files[0].name;
        } else {
            this.fileNameTarget.textContent = "No file uploaded";
        }
    }

    uploadData() {
        if(this.fileInputTarget.files.length > 0) {
            const selectedFile = this.fileInputTarget.files[0];
            const formData = new FormData();
            formData.append('salesData', selectedFile);
            formData.append('authenticity_token', this.authenticityTokenTarget.value);
            fetch('/upload', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Server was unable to process the sales data.');
                }
                return response.json();
            })
            .then(result => {
                this.showSuccessMessage('Successfully uploaded and processed the sales data!')
            })
            .catch(err => {
                this.showErrorMessage(err);
            });
        } else {
            this.showErrorMessage('Please specify a CSV file to upload');
        }
    }

    clearFileInput() {
        this.fileInputTarget.value = "";
        this.handleFileSelect();
        this.dismissSuccessMessage();
        this.dismissErrorMessage();
    }

    dismissSuccessMessage() {
        this.messagesSectionTarget.classList.add('is-hidden');
        this.successMessageContentsTarget.textContent = '';
        this.successMessageTarget.classList.add('is-hidden');
    }

    dismissErrorMessage() {
        this.messagesSectionTarget.classList.add('is-hidden');
        this.errorMessageContentsTarget.textContent = '';
        this.errorMessageTarget.classList.add('is-hidden');
    }

    showErrorMessage(contents) {
        setTimeout(() => {
            this.dismissErrorMessage();
        }, 5000);
        this.messagesSectionTarget.classList.remove('is-hidden');
        this.errorMessageContentsTarget.textContent = contents;
        this.errorMessageTarget.classList.remove('is-hidden');
    }

    showSuccessMessage(contents) {
        setTimeout(() => {
            this.dismissSuccessMessage();
        }, 5000);
        this.messagesSectionTarget.classList.remove('is-hidden');
        this.successMessageContentsTarget.textContent = contents;
        this.successMessageTarget.classList.remove('is-hidden');
    }
}
