select vendor_id, sum(invoice_total) as invoice_total_sum from invoices group by vendor_id
