# User options
GENDER = ["boy","girl"]

STYLE = {
    "athletic" => 0,
    "formal" => 1,
    "everyday" => 2,
    "trendy" => 3
}
 
SIZE  = {
    "0-3mo" => 0,
    "3-6mo" => 1,
    "6-9mo" => 2,
    "12-18mo" => 3,
    "24mo" => 4,
    "2T" => 5,
    "3T" => 6,
    "4T" => 7,
    "5T" => 8
  }

# Adding constant for box status, allowing for business to update in the future
BOX_STATUSES = {
    0 => "Processing",
    1 => "Shipped",
    2 => "Delivered",
    3 => "Returned",
    4 => "Unsuccessful"
}
