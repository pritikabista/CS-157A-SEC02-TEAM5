document.addEventListener("DOMContentLoaded", function () {
  setActiveSidebar();
  setupExpandableRows();
  setupQuantityButtons();
});

function setActiveSidebar() {
  var current = window.location.pathname.split("/").pop();
  var links = document.querySelectorAll(".sidebar a");

  for (var i = 0; i < links.length; i++) {
    var href = links[i].getAttribute("href");
    if (href && href.indexOf(current) !== -1) {
      links[i].classList.add("active");
    }
  }
}

function setupExpandableRows() {
  var clickableRows = document.querySelectorAll(".clickable-row");

  for (var i = 0; i < clickableRows.length; i++) {
    clickableRows[i].addEventListener("click", function () {
      var targetId = this.getAttribute("data-target");
      if (!targetId) {
        return;
      }

      var expandedRow = document.getElementById(targetId);
      if (!expandedRow) {
        return;
      }

      if (expandedRow.style.display === "table-row") {
        expandedRow.style.display = "none";
      } else {
        expandedRow.style.display = "table-row";
      }
    });
  }
}

function toggleExpand(id) {
  var row = document.getElementById(id);
  if (!row) {
    return;
  }

  if (row.style.display === "table-row") {
    row.style.display = "none";
  } else {
    row.style.display = "table-row";
  }
}

function closeRow(event, id) {
  if (event) {
    event.stopPropagation();
  }

  var row = document.getElementById(id);
  if (row) {
    row.style.display = "none";
  }
}

function setupQuantityButtons() {
  var minusButtons = document.querySelectorAll(".qty-btn.minus");
  var plusButtons = document.querySelectorAll(".qty-btn.plus");

  for (var i = 0; i < minusButtons.length; i++) {
    minusButtons[i].addEventListener("click", function (event) {
      event.stopPropagation();
      updateQty(this, -1);
    });
  }

  for (var j = 0; j < plusButtons.length; j++) {
    plusButtons[j].addEventListener("click", function (event) {
      event.stopPropagation();
      updateQty(this, 1);
    });
  }
}

function changeQty(event, id, change) {
  if (event) {
    event.stopPropagation();
  }

  var qtyElement = document.getElementById(id);
  if (!qtyElement) {
    return;
  }

  var current = parseInt(qtyElement.textContent, 10);
  if (isNaN(current)) {
    current = 1;
  }

  current = current + change;
  if (current < 1) {
    current = 1;
  }

  qtyElement.textContent = current;
}

function updateQty(button, change) {
  var parent = button.parentNode;
  if (!parent) {
    return;
  }

  var qtyValue = parent.querySelector(".qty-value");
  if (!qtyValue) {
    return;
  }

  var current = parseInt(qtyValue.textContent, 10);
  if (isNaN(current)) {
    current = 1;
  }

  current = current + change;
  if (current < 1) {
    current = 1;
  }

  qtyValue.textContent = current;
}