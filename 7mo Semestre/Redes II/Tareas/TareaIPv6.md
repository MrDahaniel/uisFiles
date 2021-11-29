## IPv6 Subnetting Problems

### Problem 1

#### Subnets Based on User Groups

**ISP Address:** 2001:EE00:2575::/48

-   Infrastructure Site ID: 2001:EE00:2575::/52
-   Sales Site ID: 2001:EE00:2575:1000::/52
-   Accounting Site ID: 2001:EE00:2575:2000::/52
-   Distribution Site ID: 2001:EE00:2575:3000::/52
-   Casting Site ID: 2001:EE00:2575:4000::/52
-   Editing Site ID: 2001:EE00:2575:5000::/52

#### Subnets Based on Location

**ISP Address:** 2001:EE00:2575::/48

-   Infrastructure Site ID: 2001:EE00:2575::/52
-   Administration Site ID: 2001:EE00:2575:1000::/52
    -   Infrastructure Sub-Site ID: 2001:EE00:2575:1000::/56
    -   Sales Sub-Site ID: 2001:EE00:2575:1100::/56
    -   Accounting Sub-Site ID: 2001:EE00:2575:1200::/56
    -   Distribution Sub-Site ID: 2001:EE00:2575:1300::/56
-   Production Site ID: 2001:EE00:2575:2000::/52
    -   Infrastructure Sub-Site ID: 2001:EE00:2575:2000::/56
    -   Casting Sub-Site ID: 2001:EE00:2575:2100::/56
    -   Editing Sub-Site ID: 2001:EE00:2575:2200::/56

### Problem 2

#### Subnets Based on User Groups

**ISP Address:** 3F01:ABCD:8875::/48

-   Infrastructure Site ID: 3F01:ABCD:8875::/52
-   Management Site ID: 3F01:ABCD:8875:1000::/52
-   Sales Site ID: 3F01:ABCD:8875:2000::/52
-   Human Resources Site ID: 3F01:ABCD:8875:3000::/52
-   Warehouse Site ID: 3F01:ABCD:8875:1000:4000::/52

#### Subnets Based on Location

**ISP Address:**

-   Infrastructure Site ID: ID: 3F01:ABCD:8875::/52
-   Building 1 Site ID: ID: 3F01:ABCD:8875:1000::/52
    -   Infrastructure Sub-Site ID: 3F01:ABCD:8875:1000::/56
    -   Management Sub-Site ID: 3F01:ABCD:8875:1100::/56
    -   Sales Sub-Site ID: 3F01:ABCD:8875:1200::/56
-   Building 2 Site ID:ID: 3F01:ABCD:8875:2000::/52
    -   Infrastructure Sub-Site ID: 3F01:ABCD:8875:2000::/56
    -   Management Sub-Site ID: 3F01:ABCD:8875:2100::/56
    -   Human Resources Sub-Site ID: 3F01:ABCD:8875:2200::/56
-   Building 3 Site ID: 3F01:ABCD:8875:3000::/52
    -   Infrastructure Sub-Site ID: 3F01:ABCD:8875:3000::/56
    -   Management Sub-Site ID: 3F01:ABCD:8875:3100::/56
    -   Warehouse Sub-Site ID: 3F01:ABCD:8875:3200::/56

### Problem 3

#### Subnets Based on User Groups

**ISP Address:** 2001:CA21:9000::/48

-   Infrastructure Site ID: 2001:CA21:9000::/52
-   Management Groups Site ID: 2001:CA21:9000:1000::/52
    -   HR Sub-Site ID: 2001:CA21:9000:1000::/56
    -   Sales Sub-Site ID: 2001:CA21:9000:1100::/56
        -   Wholesale Sub- Site ID: 2001:CA21:9000:1100::/60
        -   Retail Sub- Site ID: 2001:CA21:9000:1110::/60
-   Production Groups Site ID: 2001:CA21:9000:2000::/52
    -   Warehouse Sub-Site ID: 2001:CA21:9000:2000::/56
    -   Shipping Sub-Site ID: 2001:CA21:9000:2100::/56
        -   Domestic Sub-Site ID: 2001:CA21:9000:2100::/60
        -   Worldwide Sub-Site ID: 2001:CA21:9000:2110::/60

#### Subnets Based on Location

**ISP Address:** 2001:CA21:9000::/48

-   Infrastructure Site ID: 2001:CA21:9000::/52
-   Building A Site ID: 2001:CA21:9000:1000::/52
    -   Infrastructure Sub-Site ID: 2001:CA21:9000:1000::/56
    -   HR Sub-Site ID: 2001:CA21:9000:1100::/56
    -   Sales Sub-Site ID: 2001:CA21:9000:1200::/56
        -   Wholesale Sub-Site ID: 2001:CA21:9000:1200::/60
        -   Retail Sub-Site ID: 2001:CA21:9000:1210::/60
-   Building B Site ID: 2001:CA21:9000:2000::/52
    -   Infrastructure Sub-Site ID: 2001:CA21:9000:2000::/56
    -   Warehouse Sub-Site ID: 2001:CA21:9000:2100::/56
    -   Shipping Sub-Site ID: 2001:CA21:9000:2200::/56
        -   Domestic Sub-Site ID: 2001:CA21:9000:2200::/60
        -   Worldwide Sub-Site ID: 2001:CA21:9000:2210::/60

### Problem 4

#### Subnets Based on User Groups

**ISP Address:** 2000:ACAD:1145::/48

-   Infrastructure Site ID: 2000:ACAD:1145::/52
-   Administration Site ID: 2000:ACAD:1145:1000::/52
-   Finance Site ID: 2000:ACAD:1145:2000::/52
-   Guest Access Site ID: 2000:ACAD:1145:3000::/52
-   Marketing Site ID: 2000:ACAD:1145:4000::/52
-   Bookkeeping Site ID: 2000:ACAD:1145:5000::/52

#### Subnets Based on Location

**ISP Address:** 2000:ACAD:1145::/48

-   Infrastructure Site ID: 2000:ACAD:1145::/52
-   Office A Site ID: 2000:ACAD:1145:1000::/52
    -   Infrastructure Sub-Site ID: 2000:ACAD:1145:1000::/56
    -   Management Sub-Site ID: 2000:ACAD:1145:1100::/56
        -   Administration Sub-Site ID: 2000:ACAD:1145:1100::/60
        -   Finance Sub-Site ID: 2000:ACAD:1145:1110::/60
    -   Wireless Access Sub-Site ID: 2000:ACAD:1145:1200::/56
        -   Guest Access Sub-Site ID: 2000:ACAD:1145:1200::/60
        -   Marketing Sub-Site ID: 2000:ACAD:1145:1210::/60
-   Office B Site ID: 2000:ACAD:1145:2000::/52
    -   Infrastructure Sub-Site ID: 2000:ACAD:1145:2000::/56
    -   Management Sub-Site ID: 2000:ACAD:1145:2100::/56
        -   Administration Sub-Site ID: 2000:ACAD:1145:2100::/60
    -   Production Sub-Site ID: 2000:ACAD:1145:2200::/56
        -   Administration Sub-Site ID: 2000:ACAD:1145:2200::/60
        -   Bookkeeping Sub-Site ID: 2000:ACAD:1145:2210::/60
    -   Wireless Access Sub-Site ID: 2000:ACAD:1145:2300::/56
        -   Guest Access Sub-Site ID: 2000:ACAD:1145:2300::/60

### Problem 5

#### Subnets Based on User Groups

**ISP Address:** 3F01:AA07:3907::/48

-   Infrastructure Site ID: 3F01:AA07:3907::/52
-   Manufacturing Groups Site ID: 3F01:AA07:3907:1000::/52
    -   Infrastructure Sub-Site ID: 3F01:AA07:3907:1000::/56
    -   Marketing Sub-Site ID: 3F01:AA07:3907:1100::/56
    -   Inventory Sub-Site ID: 3F01:AA07:3907:1200::/56
    -   Shipping Sub- Site ID: 3F01:AA07:3907:1300::/56
-   Admin Groups Site ID: 3F01:AA07:3907:2000::/52
    -   Infrastructure Sub-Site ID: 3F01:AA07:3907:2000::/56
    -   HR Sub-Site ID: 3F01:AA07:3907:2100::/56
        -   Hiring Sub-Site ID: 3F01:AA07:3907:2100::/60
        -   Benefits Sub-Site ID: 3F01:AA07:3907:2110::/60
    -   Financial Sub-Site ID: 3F01:AA07:3907:2200::/56
        -   Purchasing Sub-Site ID: 3F01:AA07:3907:2200::/60
        -   Sales Sub-Site ID: 3F01:AA07:3907:2210::/60

#### Subnets Based on Location

**ISP Address:** 3F01:AA07:3907::/48

-   Infrastructure Site ID: 3F01:AA07:3907::/52
-   33rd Floor Site ID: 3F01:AA07:3907:1000::/52
    -   Infrastructure Sub-Site ID: 3F01:AA07:3907:1000::/56
    -   Manufacturing Groups Sub-Site ID: 3F01:AA07:3907:1100::/56
        -   Marketing Sub-Site ID: 3F01:AA07:3907:1100::/60
        -   Inventory Sub-Site ID: 3F01:AA07:3907:1110::/60
        -   Shipping Sub-Site ID: 3F01:AA07:3907:1120::/60
-   34th Floor Site ID: 3F01:AA07:3907:2000::/52
    -   Infrastructure Sub-Site ID: 3F01:AA07:3907:2000::/56
    -   Admin Groups Sub-Site ID: 3F01:AA07:3907:2100::/56
        -   HR Sub-Site ID: 3F01:AA07:3907:2100::/60
            -   Hiring Sub-Site ID: 3F01:AA07:3907:2100::/64
        -   Benefits Sub-Site ID: 3F01:AA07:3907:2101::/64
    -   Financial Sub-Site ID: 3F01:AA07:3907:2200::/56
        -   Purchasing Sub-Site ID: 3F01:AA07:3907:2200::/60
        -   Sales Sub-SiteID: 3F01:AA07:3907:2210::/60

### Problem 6

#### Subnets Based on User Groups

**ISP Address:** 2001:0:17::/52

-   Infrastructure Site ID: 2001:0:17::/56
-   Administrators Site ID: 2001:0:17:0100::/56
-   Staff Site ID: 2001:0:17:0200::/56
-   Advertising Site ID: 2001:0:17:0300::/56
    -   Infrastructure Sub-Site ID: 2001:0:17:0300::/60
    -   Radio Sub-Site ID: 2001:0:17:0310::/60
    -   TV Sub- Site ID: 2001:0:17:0320::/60
    -   Web Sub- Site ID: 2001:0:17:0330::/60
-   Sales Site ID: 2001:0:17:0400::/56
    -   Infrastructure Sub-Site ID: 2001:0:17:0400::/60
    -   Retail Sub-Site ID: 2001:0:17:0410::/60
    -   Wholesale Sub-Site ID: 2001:0:17:0420::/60

#### Subnets Based on Location

**ISP Address:** 2001:0:17::/52

-   Infrastructure Site ID: 2001:0:17::/56
-   Management Site ID: 2001:0:17:0100::/56
    -   Infrastructure Sub-Site ID: 2001:0:17:0100::/60
    -   Administrators Sub-Site ID: 2001:0:17:0110::/60
    -   Staff Sub- Site ID: 2001:0:17:0120::/60
-   Finance Site ID: 2001:0:17:0200::/56
    -   Infrastructure Sub-Site ID: 2001:0:17:0200::/60
    -   Staff Sub-Site ID: 2001:0:17:0210::/60
-   Marketing Dept Site ID: 2001:0:17:0300::/56
    -   Infrastructure Sub-Site ID: 2001:0:17:0300::/60
    -   Advertising Sub-Site ID: 2001:0:17:0310::/60
        -   Radio Sub-Site ID: 2001:0:17:0310::/64
        -   TV Sub-Site ID: 2001:0:17:0311::/64
        -   Web Sub-Site ID: 2001:0:17:0312::/64
    -   Sales Sub-Site ID: 2001:0:17:0400::/56
        -   Retail Sub-Site ID: 2001:0:17:0400::/60
        -   Wholesale Sub-Site ID: 2001:0:17:0410::/60

### Problem 7

#### Subnets Based on User Groups

**ISP Address:** 3F00:3589:0:5000::/52

-   Infrastructure Site ID: 3F00:3589:0:5000::/52
-   Management Site ID: 3F00:3589:0:5100::/52
-   HR Site ID: 3F00:3589:0:5200::/52
    -   Infrastructure Sub-Site ID: 3F00:3589:0:5200::/56
    -   Record Keeping Sub-Site ID: 3F00:3589:0:5210::/56
    -   Insurance Sub-Site ID: 3F00:3589:0:5220::/56
-   Finance Site ID: 3F00:3589:0:5300::/52
    -   Infrastructure Sub-Site ID: 3F00:3589:0:5300::/56
    -   Sales Sub-Site ID: 3F00:3589:0:5310::/56
-   Purchasing Site ID: 3F00:3589:0:5400::/52
    -   Inventory Sub-Site ID: 3F00:3589:0:5400::/56
    -   Distribution Sub-Site ID: 3F00:3589:0:5410::/56

#### Subnets Based on Location

**ISP Address:** 3F00:3589:0:5000::/52

-   Infrastructure Site ID: 3F00:3589:0:5000::/56
-   Office A Site ID: 3F00:3589:0:5100::/56
    -   Infrastructure Sub-Site ID: 3F00:3589:0:5100::/60
    -   Management Sub-Site ID: 3F00:3589:0:5110::/60
    -   HR Sub- Site ID: 3F00:3589:0:5120::/60
        -   Record Keeping Sub-Site ID: 3F00:3589:0:5110::/64
        -   Insurance Sub-Site ID: 3F00:3589:0:5111::/64
-   Office B Site ID: 3F00:3589:0:5200::/56
    -   Infrastructure Sub-Site ID: 3F00:3589:0:5200::/60
    -   Management Sub-Site ID: 3F00:3589:0:5210::/60
    -   Finance Sub-Site ID: 3F00:3589:0:5220::/60
        -   Sales Sub-Site ID: 3F00:3589:0:5220::/64
-   Office C Site ID: 3F00:3589:0:5300::/56
    -   Infrastructure Sub-Site ID: 3F00:3589:0:5300::/60
    -   Management Sub-Site ID: 3F00:3589:0:5310::/60
    -   Purchasing Sub-Site ID: 3F00:3589:0:5320::/60
        -   Inventory Sub-Site ID: 3F00:3589:0:5320::/64
        -   Distribution Sub-Site ID: 3F00:3589:0:5321::/64

### Problem 8

#### Subnets Based on User Groups

**ISP Address:**

-   Infrastructure Site ID: 2000:2531:FE00::/52
-   Nurses/Staff Site ID: 2000:2531:FE00:1000::/52
-   Laboratory Site ID: 2000:2531:FE00:2000::/52
-   Obstetrics Site ID: 2000:2531:FE00:3000::/52
-   Pediatric Site ID: 2000:2531:FE00:4000::/52
-   Records Site ID: 2000:2531:FE00:5000::/52
-   Guest WIFI Site ID: 2000:2531:FE00:6000::/52

#### Subnets Based on Location

**ISP Address:**

-   Infrastructure Site ID: 2000:2531:FE00::/52
-   Emergency Site ID: 2000:2531:FE00:1000::/52
    -   Infrastructure Sub-Site ID: 2000:2531:FE00:1000::/56
    -   Nurses/Staff Sub-Site ID: 2000:2531:FE00:1100::/56
    -   Laboratory Sub-Site ID: 2000:2531:FE00:1200::/56
    -   Obstetrics Sub-Site ID: 2000:2531:FE00:1300::/56
    -   Pediatric Sub-Site ID: 2000:2531:FE00:1400::/56
-   Admissions Site ID: 2000:2531:FE00:2000::/52
    -   Infrastructure Sub-Site ID: 2000:2531:FE00:2000::/56
    -   Nurses/Staff Sub-Site ID: 2000:2531:FE00:2100::/56
    -   Records Sub-Site ID: 2000:2531:FE00:2200::/56
-   Patient Wards Site ID: 2000:2531:FE00:3000::/52
    -   Infrastructure Sub-Site ID: 2000:2531:FE00:3000::/56
    -   Ward A Sub-Site ID: 2000:2531:FE00:3100::/56
        -   Nurses/Staff Sub-Site ID: 2000:2531:FE00:3100::/60
        -   Guest WIFI Sub-Site ID: 2000:2531:FE00:3110::/60
    -   Ward B Sub-Site ID: 2000:2531:FE00:3200::/56
        -   Nurses/Staff Sub-Site ID: 2000:2531:FE00:3200::/60
        -   Guest WIFI Sub-Site ID: 2000:2531:FE00:3210::/60
