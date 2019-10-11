select account_number, sum(line_item_amt) as line_item_sum from invoice_line_items group by rollup(account_number)
