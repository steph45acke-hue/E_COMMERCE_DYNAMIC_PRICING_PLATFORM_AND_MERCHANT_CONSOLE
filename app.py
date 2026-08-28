import streamlit as st
import pandas as pd
import numpy as np

# Page Layout & Config
st.set_page_config(page_title="E-Commerce Dynamic Pricing Platform", layout="wide")

st.title("🛒 Enterprise E-Commerce Dynamic Pricing & Margin Intelligence Console")
st.markdown("Automated pricing engine processing 1,000+ SKUs with live safety guardrails, scarcity tracking, and revenue projections.")

# --- LOAD DATA ---
@st.cache_data
def load_data():
    # Reads the CSV dataset we generated and exported
    return pd.read_csv("ecommerce_pricing_catalog.csv")

df = load_data()

# --- SIDEBAR CONTROLS ---
st.sidebar.header("Pricing Engine Controls")
min_margin_slider = st.sidebar.slider("Minimum Profit Margin (%)", min_value=5.0, max_value=30.0, value=15.0, step=1.0)
stock_threshold_slider = st.sidebar.slider("Low Stock Scarcity Threshold", min_value=5, max_value=50, value=15, step=5)

category_filter = st.sidebar.selectbox("Filter by Category", options=["All"] + list(df['category'].unique()))

# Apply category filter if selected
if category_filter != "All":
    df_filtered = df[df['category'] == category_filter].copy()
else:
    df_filtered = df.copy()

# --- DYNAMIC PRICING RE-CALCULATION BASED ON SLIDERS ---
def apply_dynamic_pricing(row, margin_pct, stock_limit):
    cost = row['our_cost']
    comp_price = row['competitor_price']
    stock = row['stock_level']
    current_price = row['our_price']
    sales_velocity = row['historical_sales_volume']
    
    min_allowable_price = round(cost * (1 + (margin_pct / 100.0)), 2)
    
    if stock < stock_limit and sales_velocity > 100:
        target_price = round(comp_price * 1.03, 2)
        action = "Increase (High Demand / Low Stock)"
    elif comp_price < current_price and stock > 100:
        target_price = round(comp_price - 1.00, 2)
        action = "Match & Undercut"
    else:
        target_price = current_price
        action = "Hold Price"
        
    if target_price < min_allowable_price:
        return min_allowable_price, f"Floor Protected (${min_allowable_price})"
    
    return target_price, action

# Apply engine live based on user slider adjustments
results = df_filtered.apply(lambda row: apply_dynamic_pricing(row, min_margin_slider, stock_threshold_slider), axis=1)
df_filtered['optimized_price'] = [r[0] for r in results]
df_filtered['pricing_strategy'] = [r[1] for r in results]
df_filtered['projected_profit_per_unit'] = round(df_filtered['optimized_price'] - df_filtered['our_cost'], 2)
df_filtered['total_projected_revenue'] = round(df_filtered['optimized_price'] * df_filtered['historical_sales_volume'], 2)

# --- TOP KPI METRICS DASHBOARD ---
col1, col2, col3, col4 = st.columns(4)
col1.metric("Active SKUs Managed", len(df_filtered))
col2.metric("Average Profit / Unit", f"${df_filtered['projected_profit_per_unit'].mean():.2f}")
col3.metric("Total Projected Revenue", f"${df_filtered['total_projected_revenue'].sum():,.2f}")
col4.metric("Active Margin Floor", f"{min_margin_slider}%")

st.markdown("---")
st.subheader("Live Optimized Product Catalog")
st.dataframe(df_filtered[['product_id', 'category', 'our_cost', 'our_price', 'competitor_price', 'stock_level', 'optimized_price', 'pricing_strategy', 'projected_profit_per_unit']], use_container_width=True)