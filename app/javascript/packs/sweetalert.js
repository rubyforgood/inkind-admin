import Rails from '@rails/ujs';
import Swal from 'sweetalert2';
window.Swal = Swal;
// Behavior after click to confirm button
const confirmed = (element, result) => {
  if (result.value) {
    if (!!element.getAttribute('data-remote')) {
        let reloadAfterSuccess = !!element.getAttribute('data-reload');

        $.ajax({
            method: element.getAttribute('data-method') || 'GET',
            url: element.getAttribute('href'),
            dataType: 'json',
            success: function(result) {
                Swal.fire('Success!', result.message || '', 'success')
                    .then((_result) => {
                        if (reloadAfterSuccess) {
                            window.location.reload();
                        }
                    });
            },
            error: function(xhr) {
                let title   = 'Error!';
                let message = 'Something went wrong. Please try again later.';

                if (xhr.responseJSON && xhr.responseJSON.message) {
                    message = xhr.responseJSON.message;
                }

                Swal.fire(title, message,'error');
            }
        });
    } else {
        element.removeAttribute('data-confirm-swal');
        element.click();
    }
  }
};
// Display the confirmation dialog
const showConfirmationDialog = (element) => {
  const message = element.getAttribute('data-confirm-swal');
  const text    = element.getAttribute('data-text');
  const confirmText = element.getAttribute('data-confirm-text')

  Swal.fire({
      title:             message || 'Are you sure?',
      text:              text || '',
      showCancelButton:  true,
      cancelButtonText:  'CANCEL',
      confirmButtonText: confirmText || "YES",
      reverseButtons: true,
      confirmButtonColor: "#6C3CB2",
  }).then(result => confirmed(element, result));
};

const allowAction = (element) => {
    if (element.getAttribute('data-confirm-swal') === null) {
        return true;
    }

    showConfirmationDialog(element);
    return false;
};

function handleConfirm(element) {
    if (!allowAction(this)) {
        Rails.stopEverything(element);
    }
}

Rails.delegate(document, 'a[data-confirm-swal]', 'click', handleConfirm);
