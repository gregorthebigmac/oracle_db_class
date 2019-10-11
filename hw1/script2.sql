select vendor_name, sum(payment_total) as payment_total_sum from vendors join invoices on vendors.vendor_id = invoices.vendor_id group by vendor_name order by payment_total_sum desc
