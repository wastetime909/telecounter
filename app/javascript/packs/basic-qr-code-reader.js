import { BrowserQRCodeReader } from '@zxing/library';
import Rails from '@rails/ujs';

const codeReader = new BrowserQRCodeReader();

codeReader
    .decodeFromInputVideoDevice(undefined, 'video')
    .then((result) => {
        let qrDataFromReader = result.text;

        let formData = new FormData();

        let qrCodeParams = {
            qr_data: qrDataFromReader
        };

        formData.append("qr_code_json_data", JSON.stringify(qrCodeParams));
        Rails.ajax({
            url: "/scanner/scan_result",
            type: "post",
            data: formData
        });

    })
    .catch(error => {
        console.error(error);
    });