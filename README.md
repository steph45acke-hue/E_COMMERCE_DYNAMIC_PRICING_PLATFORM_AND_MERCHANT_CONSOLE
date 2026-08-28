# 🛒 E-Commerce Dynamic Pricing & Margin Intelligence Platform
<p align="center">
  <img src="banner.png" alt="E-Commerce Dynamic Pricing & Margin Intelligence Platform" width="100%">
</p>

---

## 📌 Project Overview
The E-Commerce Dynamic Pricing and Margin Intelligence Platform is an advanced data-driven system built to optimize online product pricing. It bridges the gap between raw database engineering, automated pricing algorithms, and real-time interactive web dashboards. By continuously monitoring inventory health, competitor pricing data, and profit margins, the platform dynamically recommends or enforces optimal prices to maximize revenue while safeguarding baseline profitability.

---

## ❓ Why We Did This Project (The Problem)
In modern e-commerce, manual pricing is slow, inefficient, and prone to severe financial risks:
* **Margin Erosion:** Merchants often drop prices to beat competitors without checking their cost basis, resulting in items being sold at a loss.
* **Dead-Stock Capital Lockup:** Excess inventory ties up valuable warehouse space and cash flow because items fail to move when priced too high.
* **Stockouts on High-Demand Items:** Fast-selling products with low stock levels run out quickly if prices are not adjusted upward to manage demand scarcity.
* **Data Disconnection:** Raw transactional data and competitor scraping data usually sit isolated in relational databases, making it difficult for stakeholders to visualize and act on pricing strategies instantly.

---

## 💡 The Solution Involved
This project solves these challenges by implementing a multi-layered automated pipeline:
1. **Relational Database Architecture:** Modeled product catalogs, competitor pricing feeds, and order transactions in MySQL Workbench to maintain clean, structured historical data.
2. **Automated Pricing Engine:** Developed custom algorithms in Python that evaluate inventory turnover, stock scarcity, and competitor rates in real-time.
3. **Safety Guardrails (Cost Floors):** Built hard-coded margin floor protection rules so that automated pricing changes can never drop below a mandatory minimum profit threshold.
4. **Interactive Web Dashboard:** Deployed a live Streamlit web application providing dynamic controls, category filters, and immediate metric tracking across thousands of SKUs.

---

## 🛠️ Technology Used
* **Python:** Core programming language used for data manipulation and engine simulation.
* **Pandas & NumPy:** High-performance libraries for structured tabular data processing and mathematical vector operations.
* **MySQL Workbench:** Relational database management system for schema design, multi-table joins, and SQL analytics.
* **Streamlit:** Framework for building and deploying interactive web applications and executive dashboards.
* **Visual Studio Code & Jupyter Notebooks:** Integrated development environments used for code execution, scripting, and iterative debugging.
* **Git & GitHub:** Version control systems used for source code management and project hosting.

---

## 📊 Project Visuals & Implementation Gallery

### Phase 1: Relational Database Architecture & SQL Analytics (MySQL Workbench)

* **Product Catalog Schema (`dim_products`):**
  ![Dim Products Schema](Screenshot%20(153).png)

* **Competitor Intelligence Feed (`competitor_prices`):**
  ![Competitor Prices Table](Screenshot%20(154).png)

* **Transactional Order History (`fact_orders`):**
  ![Fact Orders Table](Screenshot%20(155).png)

* **Order Revenue Calculation via Joins:**
  ![Order Revenue Calculation](Screenshot%20(156).png)

* **Market Positioning Classification:**
  ![Pricing Positioning Status](Screenshot%20(157).png)

* **Gross Profit Margin Analysis:**
  ![Gross Profit Margin Analysis](Screenshot%20(158).png)

* **Category-Level Inventory Exposure Summary:**
  ![Category Level Summary](Screenshot%20(159).png)

* **Dead-Stock vs High Velocity Classification:**
  ![Dead-Stock vs High Velocity Analysis](Screenshot%20(160).jpg)

* **Advanced Common Table Expressions (CTEs) for Pricing Targets:**
  ![Advanced CTE Pricing Targets](Screenshot%20(161).jpg)

---

### Phase 2: Python Core Engine & Simulation (VS Code / Jupyter Notebooks)

* **Initial Dataframe Setup:**
  ![Jupyter Notebook Dataframe Setup](Screenshot%20(162).png)

* **Core Pricing Engine Logic Implementation:**
  ![Core Pricing Engine Logic](Screenshot%20(163).png)

* **Advanced Profit Margin Floor Guardrails:**
  ![Advanced Margin Floor Guardrails](Screenshot%20(165).png)

* **Enterprise-Scale Data Generation (1,000+ SKUs):**
  ![Enterprise Scale Data Generation](Screenshot%20(167).png)

* **CSV Export Confirmation:**
  ![CSV Export Confirmation](Screenshot%20(168).png)

---

### Phase 3: Interactive Streamlit Web Console

* **Initial Local Web Dashboard Preview:**
  ![Initial Streamlit Dashboard Preview](Screenshot%20(166).png)

* **Fully Scaled Enterprise Dynamic Pricing Dashboard:**
  ![Scaled Enterprise Dashboard](Screenshot%20(169).jpg)

---

## 🚀 How to Use It

1. **Clone the Repository:**
   ```bash
   git clone [https://github.com/steph45acke-hue/E-COMMERCE-DYNAMIC-PRICING-PLATFORM.git](https://github.com/steph45acke-hue/E-COMMERCE-DYNAMIC-PRICING-PLATFORM.git)
   cd E-COMMERCE-DYNAMIC-PRICING-PLATFORM

