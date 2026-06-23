# 📚 Bookstore Sales Analysis — SQL Project

A beginner SQL project analyzing a fictional online bookstore's sales data using PostgreSQL. The project covers schema design, data import, and querying across three related tables.

---

## 📁 Dataset

| Table | Rows | Description |
|---|---|---|
| `books` | 500 | Book catalog with genre, author, price, stock |
| `customers` | 500 | Customer info from 215 countries |
| `orders` | 500 | Orders placed between Dec 2022 – Dec 2024 |

---

## 🗂️ Schema

```
BOOKS
├── book_id (PK)
├── title
├── author
├── genre
├── published_year
├── price
└── stock

CUSTOMERS
├── customer_id (PK)
├── name
├── email
├── phone
├── city
└── country

ORDERS
├── order_id (PK)
├── customer_id (FK → customers)
├── book_id (FK → books)
├── order_date
├── quantity
└── total_amount
```

---

## 🔍 Queries Covered

**Basic**
- Filter by genre, year, country, date range
- Aggregate total stock and revenue
- Sort and rank with `ORDER BY` + `LIMIT`
- JOIN customers with orders

**Advanced**
- Books sold per genre using `GROUP BY` + `JOIN`
- Customers with 2+ orders using `HAVING`
- Most frequently ordered book
- Top spender using aggregated `SUM`
- Remaining stock after fulfilling orders using `LEFT JOIN` + `COALESCE`

---

## 📊 Key Findings

- **Total Revenue:** $75,628.66 across 500 orders
- **Average Order Value:** $151.26
- **Most Sold Genre:** Mystery (504 units sold)
- **Highest Revenue Genre:** Romance ($13,086.98)
- **Total Books in Stock:** 25,056 units across 500 titles
- **Customer Reach:** 215 countries

---

## 🚀 How to Run

1. Set up PostgreSQL locally or use [Neon](https://neon.tech) / [Supabase](https://supabase.com) (free cloud options)
2. Run `queries.sql` to create tables
3. Import data:
```sql
COPY books FROM '/your/path/data/Books.csv' CSV HEADER;
COPY customers FROM '/your/path/data/Customers.csv' CSV HEADER;
COPY orders FROM '/your/path/data/Orders.csv' CSV HEADER;
```
4. Run individual queries from `queries.sql`

---

## 🛠️ Tools Used

- PostgreSQL
- pgAdmin / psql

---

## 👤 Author

Bhupesh | B.A. Economics + PG Diploma in Data Analytics  
[LinkedIn](#) • [GitHub](#)
