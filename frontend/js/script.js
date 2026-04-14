const inventoryItems = [
  {
    id: 1,
    ref: "MED-1001",
    name: "Surgical Gloves",
    lotNumber: "LOT-A123",
    expirationDate: "2026-05-10",
    location: "Main Store - Shelf A2",
    quantity: 8,
    category: "PPE",
    department: "ER",
    details: "Sterile latex-free gloves used in procedures.",
    lowStock: true,
    expiringSoon: true
  },
  {
    id: 2,
    ref: "MED-1002",
    name: "Syringes 10ml",
    lotNumber: "LOT-B845",
    expirationDate: "2027-02-15",
    location: "ICU - Cabinet 3",
    quantity: 120,
    category: "Injection Supplies",
    department: "ICU",
    details: "Single-use sterile syringes for general medication administration.",
    lowStock: false,
    expiringSoon: false
  },
  {
    id: 3,
    ref: "MED-1003",
    name: "IV Saline Bag",
    lotNumber: "LOT-C301",
    expirationDate: "2026-06-01",
    location: "Ward 2 - Fridge 1",
    quantity: 15,
    category: "Fluids",
    department: "Ward 2",
    details: "Normal saline IV bags for routine fluid replacement.",
    lowStock: false,
    expiringSoon: true
  },
  {
    id: 4,
    ref: "MED-1004",
    name: "N95 Mask",
    lotNumber: "LOT-D901",
    expirationDate: "2027-09-20",
    location: "ER - Room 5",
    quantity: 5,
    category: "PPE",
    department: "ER",
    details: "Protective mask for airborne safety procedures.",
    lowStock: true,
    expiringSoon: false
  }
];

const requests = [
  {
    id: "REQ-201",
    user: "Pritika",
    item: "Surgical Gloves",
    ref: "MED-1001",
    message: "Current stock is running low in ER. Please approve reorder soon.",
    details: "Sterile latex-free gloves used in procedures."
  },
  {
    id: "REQ-202",
    user: "Alex",
    item: "N95 Mask",
    ref: "MED-1004",
    message: "Need more N95 masks for respiratory isolation cases.",
    details: "Protective mask for airborne safety procedures."
  }
];

const orders = [
  { id: "ORD-301", item: "Surgical Gloves", status: "In Process" },
  { id: "ORD-302", item: "Syringes 10ml", status: "Done" }
];

const suppliers = [
  { name: "MedSupply Co.", phone: "(408) 555-1200", url: "https://example.com" }
];

function saveLocalData() {
  localStorage.setItem("medims_inventory", JSON.stringify(inventoryItems));
  localStorage.setItem("medims_requests", JSON.stringify(requests));
  localStorage.setItem("medims_orders", JSON.stringify(orders));
  localStorage.setItem("medims_suppliers", JSON.stringify(suppliers));
}

function loadLocalData() {
  const inv = JSON.parse(localStorage.getItem("medims_inventory"));
  const req = JSON.parse(localStorage.getItem("medims_requests"));
  const ord = JSON.parse(localStorage.getItem("medims_orders"));
  const sup = JSON.parse(localStorage.getItem("medims_suppliers"));

  if (inv) {
    inventoryItems.length = 0;
    inventoryItems.push(...inv);
  }
  if (req) {
    requests.length = 0;
    requests.push(...req);
  }
  if (ord) {
    orders.length = 0;
    orders.push(...ord);
  }
  if (sup) {
    suppliers.length = 0;
    suppliers.push(...sup);
  }
}

loadLocalData();

function setActiveSidebar() {
  const current = window.location.pathname.split("/").pop();
  document.querySelectorAll(".sidebar nav a").forEach(link => {
    const href = link.getAttribute("href");
    if (href && href.includes(current)) {
      link.classList.add("active");
    }
  });
}

function handleLogin() {
  const form = document.getElementById("loginForm");
  if (!form) return;

  form.addEventListener("submit", function (e) {
    e.preventDefault();

    const role = document.getElementById("role").value;
    const username = document.getElementById("username").value.trim();
    const departmentId = document.getElementById("departmentId").value.trim();

    localStorage.setItem("medims_role", role);
    localStorage.setItem("medims_username", username || "User");
    localStorage.setItem("medims_departmentId", departmentId || "D001");

    if (role === "Admin") {
      window.location.href = "admin-dashboard.html";
    } else {
      window.location.href = "user-inventory.html";
    }
  });
}

function createExpandedContent(item, role) {
  const detailPage = role === "admin"
    ? `update-inventory.html?id=${item.id}`
    : `user-request.html?id=${item.id}`;

  return `
    <div class="expanded-card">
      <div class="expanded-grid">
        <div class="info-box"><span>Reference Number</span>${item.ref}</div>
        <div class="info-box"><span>Item Name</span>${item.name}</div>
        <div class="info-box"><span>Lot Number</span>${item.lotNumber}</div>
        <div class="info-box"><span>Expiration Date</span>${item.expirationDate}</div>
        <div class="info-box"><span>Location</span>${item.location}</div>
        <div class="info-box"><span>Category</span>${item.category}</div>
        <div class="info-box"><span>Department</span>${item.department}</div>
        <div class="info-box"><span>Details</span>${item.details}</div>
      </div>

      <div class="qty-control">
        <button class="qty-btn gray" onclick="changeQty(this, -1)">-</button>
        <div class="qty-value">1</div>
        <button class="qty-btn gray" onclick="changeQty(this, 1)">+</button>
      </div>

      <div class="action-row">
        ${
          role === "admin"
            ? `
              <button onclick="goToUpdate(${item.id})">Update</button>
              <button class="secondary" onclick="goToRequestFromItem(${item.id}, 'admin')">Request</button>
            `
            : `
              <button onclick="withdrawItem(${item.id}, this)">Withdraw</button>
              <button class="secondary" onclick="goToRequestFromItem(${item.id}, 'user')">Request</button>
            `
        }
      </div>
    </div>
  `;
}

function changeQty(button, change) {
  const valueEl = button.parentElement.querySelector(".qty-value");
  let value = parseInt(valueEl.textContent, 10);
  value = Math.max(1, value + change);
  valueEl.textContent = value;
}

function withdrawItem(itemId, button) {
  const qtyValue = parseInt(
    button.closest(".expanded-card").querySelector(".qty-value").textContent,
    10
  );

  const item = inventoryItems.find(i => i.id === itemId);
  if (!item) return;

  if (qtyValue > item.quantity) {
    alert("Cannot withdraw more than available quantity.");
    return;
  }

  item.quantity -= qtyValue;
  item.lowStock = item.quantity <= 10;
  saveLocalData();
  alert(`Withdrawn ${qtyValue} from ${item.name}.`);
  location.reload();
}

function goToRequestFromItem(itemId, role) {
  localStorage.setItem("selected_item_id", itemId);
  window.location.href = role === "admin" ? "purchase-requests.html" : "user-request.html";
}

function goToUpdate(itemId) {
  localStorage.setItem("selected_item_id", itemId);
  window.location.href = `update-inventory.html?id=${itemId}`;
}

function renderInventoryTable(role) {
  const tableBody = document.getElementById("inventoryTableBody");
  if (!tableBody) return;

  const search = document.getElementById("searchInput")?.value.toLowerCase() || "";
  const category = document.getElementById("categoryFilter")?.value || "";
  const sort = document.getElementById("sortFilter")?.value || "";

  let items = [...inventoryItems];

  if (search) {
    items = items.filter(item =>
      item.name.toLowerCase().includes(search) ||
      item.ref.toLowerCase().includes(search) ||
      item.location.toLowerCase().includes(search)
    );
  }

  if (category) {
    if (category === "Expiring Soon") {
      items = items.filter(item => item.expiringSoon);
    } else {
      items = items.filter(item => item.category === category);
    }
  }

  if (sort === "Alphabetical") {
    items.sort((a, b) => a.name.localeCompare(b.name));
  } else if (sort === "Expiry") {
    items.sort((a, b) => new Date(a.expirationDate) - new Date(b.expirationDate));
  }

  tableBody.innerHTML = "";

  items.forEach(item => {
    const rowClass = item.lowStock
      ? "low-stock"
      : item.expiringSoon
      ? "expiring-soon"
      : "";

    const row = document.createElement("tr");
    row.className = `data-row ${rowClass}`;
    row.innerHTML = `
      <td>${item.ref}</td>
      <td>${item.name}</td>
      <td>${item.lotNumber}</td>
      <td>${item.expirationDate}</td>
      <td>${item.location}</td>
      <td>${item.quantity}</td>
    `;

    const expanded = document.createElement("tr");
    expanded.className = "expanded-row";
    expanded.style.display = "none";
    expanded.innerHTML = `
      <td colspan="6">
        ${createExpandedContent(item, role)}
      </td>
    `;

    row.addEventListener("click", () => {
      expanded.style.display = expanded.style.display === "none" ? "table-row" : "none";
    });

    tableBody.appendChild(row);
    tableBody.appendChild(expanded);
  });
}

function setupInventoryPage(role) {
  if (!document.getElementById("inventoryTableBody")) return;

  renderInventoryTable(role);

  ["searchInput", "categoryFilter", "sortFilter"].forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.addEventListener("input", () => renderInventoryTable(role));
      el.addEventListener("change", () => renderInventoryTable(role));
    }
  });
}

function setupUserRequestPage() {
  const itemField = document.getElementById("requestItem");
  const form = document.getElementById("requestForm");
  if (!itemField || !form) return;

  const selectedId = parseInt(localStorage.getItem("selected_item_id"), 10);
  const item = inventoryItems.find(i => i.id === selectedId);

  if (item) {
    itemField.value = `${item.name} (${item.ref})`;
  }

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const username = localStorage.getItem("medims_username") || "User";
    const message = document.getElementById("requestMessage").value.trim();

    if (!item) {
      alert("No item selected.");
      return;
    }

    requests.push({
      id: `REQ-${Math.floor(Math.random() * 900 + 100)}`,
      user: username,
      item: item.name,
      ref: item.ref,
      message,
      details: item.details
    });

    saveLocalData();
    alert("Request submitted successfully.");
    window.location.href = "user-inventory.html";
  });
}

function setupUpdateInventoryPage() {
  const form = document.getElementById("updateInventoryForm");
  if (!form) return;

  const params = new URLSearchParams(window.location.search);
  const id = parseInt(params.get("id") || localStorage.getItem("selected_item_id"), 10);
  const item = inventoryItems.find(i => i.id === id);

  if (item) {
    document.getElementById("itemName").value = item.name;
    document.getElementById("referenceNumber").value = item.ref;
    document.getElementById("lotId").value = item.lotNumber;
    document.getElementById("expirationDate").value = item.expirationDate;
    document.getElementById("quantity").value = item.quantity;
    document.getElementById("category").value = item.category;
  }

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    if (!item) return;

    item.name = document.getElementById("itemName").value;
    item.ref = document.getElementById("referenceNumber").value;
    item.lotNumber = document.getElementById("lotId").value;
    item.expirationDate = document.getElementById("expirationDate").value;
    item.quantity = parseInt(document.getElementById("quantity").value, 10);
    item.category = document.getElementById("category").value;
    item.lowStock = item.quantity <= 10;

    saveLocalData();
    alert("Inventory item updated.");
    window.location.href = "admin-inventory.html";
  });
}

function renderRequestsList() {
  const body = document.getElementById("requestsTableBody");
  if (!body) return;

  body.innerHTML = "";

  requests.forEach(req => {
    const row = document.createElement("tr");
    row.className = "data-row";
    row.innerHTML = `
      <td>${req.id}</td>
      <td>${req.user}</td>
      <td>${req.item}</td>
    `;
    row.addEventListener("click", () => {
      localStorage.setItem("selected_request_id", req.id);
      window.location.href = `request-detail.html?id=${req.id}`;
    });
    body.appendChild(row);
  });
}

function setupRequestDetailPage() {
  const messageBox = document.getElementById("requestMessageView");
  if (!messageBox) return;

  const params = new URLSearchParams(window.location.search);
  const id = params.get("id") || localStorage.getItem("selected_request_id");
  const req = requests.find(r => r.id === id);

  if (!req) return;

  document.getElementById("detailRequestId").textContent = req.id;
  document.getElementById("detailUser").textContent = req.user;
  document.getElementById("detailItem").textContent = `${req.item} (${req.ref})`;
  document.getElementById("detailMessage").textContent = req.message;
  document.getElementById("detailItemInfo").textContent = req.details;

  document.getElementById("makePurchaseBtn").addEventListener("click", () => {
    orders.push({
      id: `ORD-${Math.floor(Math.random() * 900 + 100)}`,
      item: req.item,
      status: "In Process"
    });

    saveLocalData();
    alert("Request approved and moved to orders.");
    window.location.href = "orders.html";
  });
}

function renderOrdersPage() {
  const body = document.getElementById("ordersTableBody");
  if (!body) return;

  body.innerHTML = "";

  orders.forEach((order, index) => {
    const row = document.createElement("tr");
    const badgeClass = order.status === "Done" ? "done" : "process";

    row.innerHTML = `
      <td>${order.id}</td>
      <td>${order.item}</td>
      <td><span class="badge ${badgeClass}">${order.status}</span></td>
      <td>
        <div class="action-row">
          <button onclick="approveOrder(${index})">Approve Order</button>
          <button class="secondary" onclick="toggleOrderStatus(${index})">Update Status</button>
        </div>
      </td>
    `;
    body.appendChild(row);
  });
}

function approveOrder(index) {
  orders[index].status = "In Process";
  saveLocalData();
  renderOrdersPage();
}

function toggleOrderStatus(index) {
  orders[index].status = orders[index].status === "Done" ? "In Process" : "Done";
  saveLocalData();
  renderOrdersPage();
}

function setupSupplierForm() {
  const form = document.getElementById("supplierForm");
  const list = document.getElementById("supplierList");
  if (!form || !list) return;

  const render = () => {
    list.innerHTML = "";
    suppliers.forEach((s) => {
      const item = document.createElement("div");
      item.className = "card mt-16";
      item.innerHTML = `
        <h3>${s.name}</h3>
        <p class="note">Phone: ${s.phone}</p>
        <p class="note">URL: ${s.url}</p>
      `;
      list.appendChild(item);
    });
  };

  render();

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    suppliers.push({
      name: document.getElementById("supplierName").value,
      phone: document.getElementById("supplierPhone").value,
      url: document.getElementById("supplierUrl").value
    });

    saveLocalData();
    alert("Supplier added.");
    form.reset();
    render();
  });
}

function setupAddItemPage() {
  const form = document.getElementById("addItemForm");
  if (!form) return;

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const quantity = parseInt(document.getElementById("newQuantity").value, 10);

    inventoryItems.push({
      id: Date.now(),
      ref: `MED-${Math.floor(Math.random() * 9000 + 1000)}`,
      name: document.getElementById("newItemName").value,
      lotNumber: document.getElementById("newLot").value,
      expirationDate: document.getElementById("newExpiry").value,
      location: "Main Store - New Entry",
      quantity: quantity,
      category: "General",
      department: "General",
      details: "Newly added inventory item.",
      lowStock: quantity <= 10,
      expiringSoon: false
    });

    saveLocalData();
    alert("New inventory item added.");
    window.location.href = "admin-inventory.html";
  });
}

document.addEventListener("DOMContentLoaded", () => {
  setActiveSidebar();
  handleLogin();
  setupInventoryPage("user");
  setupInventoryPage("admin");
  setupUserRequestPage();
  setupUpdateInventoryPage();
  renderRequestsList();
  setupRequestDetailPage();
  renderOrdersPage();
  setupSupplierForm();
  setupAddItemPage();
});