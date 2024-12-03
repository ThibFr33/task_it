import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="timepicker"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      disableMobile: true,
      onChange: this.onChange.bind(this)
    })

  }
  onChange(selectedDates, dateStr, instance) {
    // Envoyer la valeur sélectionnée au backend ou mettre à jour un champ caché
    console.log("Selected time:", dateStr)
    // Exemple d'envoi de la valeur via fetch API
    fetch('/save-time', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ time: dateStr }),
    })
    .then(response => response.json())
    .then(data => {
      console.log('Success:', data);
    })
    .catch((error) => {
      console.error('Error:', error);
    });
  }


}
