
        /* tb_company*/
        
        DROP TABLE IF EXISTS tb_company;
        
        CREATE TABLE IF NOT EXISTS tb_company
        (
            co_code CHAR(3) NOT NULL
            ,co_name VARCHAR(50) NOT NULL
            ,co_address VARCHAR(150) NOT NULL
            ,co_city VARCHAR(50) NOT NULL
            ,co_country VARCHAR(30) NOT NULL DEFAULT 'España'
            ,last_updated_by VARCHAR(20) NOT NULL DEFAULT 'SYSTEM'
            ,last_update_date DATE NOT NULL
                        
            ,CONSTRAINT pk_company PRIMARY KEY (co_code)
        );

        /* tb_customer */

        DROP TABLE IF EXISTS tb_customer;

        CREATE TABLE IF NOT EXISTS tb_customer
        (
            cust_no CHAR(5) NOT NULL
            ,cust_name VARCHAR(50) NOT NULL
            ,cust_cif VARCHAR(15) NOT NULL
            ,last_updated_by VARCHAR(20) NOT NULL DEFAULT "SYSTEM"
            ,last_update_date DATE NOT NULL

            ,CONSTRAINT pk_cust_no PRIMARY KEY(cust_no)
        );

        /* tb_site */

        DROP TABLE IF EXISTS tb_site;

        CREATE TABLE IF NOT EXISTS tb_site
        (
            cust_no CHAR(5) NOT NULL
            ,site_id INT NOT NULL
            ,site_code CHAR(5) NOT NULL
            ,site_name VARCHAR(50) NOT NULL
            ,site_address VARCHAR(150) NOT NULL
            ,site_city VARCHAR(50) NOT NULL
            ,site_country VARCHAR(30) NOT NULL DEFAULT "España"
            ,site_phone INT NULL
            ,co_code CHAR(3) NOT NULL
            ,last_updated_by VARCHAR(20) NOT NULL DEFAULT "SYSTEM"
            ,last_update_date DATE NOT NULL

            ,CONSTRAINT pk_site PRIMARY KEY(site_id)
            ,CONSTRAINT fk_site_customer FOREIGN KEY (cust_no) REFERENCES tb_customer(cust_no)
            ,CONSTRAINT fk_site_code FOREIGN KEY (co_code) REFERENCES tb_company(co_code)
        );

        /* tb_iva */

        DROP TABLE IF EXISTS tb_iva;

        CREATE TABLE IF NOT EXISTS tb_iva
        (
            co_code CHAR(3) NOT NULL
            ,iva_id INTEGER NOT NULL
            ,iva_no VARCHAR(15) NOT NULL
            ,iva_percent INTEGER NOT NULL
            ,active_flag CHAR(1) NOT NULL DEFAULT "Y"
            ,last_updated_by VARCHAR(20) NOT NULL DEFAULT "SYSTEM"
            ,last_update_date DATE NOT NULL
        
        ,CONSTRAINT pk_iva PRIMARY KEY (iva_id)
        ,CONSTRAINT fk_iva_code FOREIGN KEY (co_code) REFERENCES tb_company(co_code)
        );


        /*tb_invoice*/

        DROP TABLE IF EXISTS tb_invoice;

        CREATE TABLE IF NOT EXISTS tb_invoice
        (
            co_code CHAR(3) NOT NULL
            ,invoice_id INT NOT NULL
            ,invoice_no VARCHAR(15) NOT NULL
            ,cust_no CHAR(5) NOT NULL
            ,site_id INT NOT NULL
            ,payed CHAR(1) NOT NULL DEFAULT "N"
            ,net_amount REAL NOT NULL
            ,iva_amount REAL NOT NULL
            ,tot_amount REAL NOT NULL
            ,last_updated_by VARCHAR(20) NOT NULL DEFAULT "SYSTEM"
            ,last_update_date DATE NOT NULL

            ,CONSTRAINT pk_invoice PRIMARY KEY (invoice_id)
            ,CONSTRAINT fk_invoice_code FOREIGN KEY (co_code) REFERENCES tb_company(co_code)
            ,CONSTRAINT fk_invoice_customer FOREIGN KEY (cust_no) REFERENCES tb_customer(cust_no)
            ,CONSTRAINT fk_customer_site FOREIGN KEY (site_id) REFERENCES tb_site(site_id)
        );

        /* tb_lines */

        DROP TABLE IF EXISTS tb_lines;

        CREATE TABLE IF NOT EXISTS tb_lines
        (
            invoice_id INT NOT NULL
            ,line_id INT NOT NULL
            ,line_num INT NOT NULL
            ,item CHAR(5) NULL
            ,description VARCHAR(120) NOT NULL
            ,net_amount REAL NOT NULL
            ,iva_amount REAL NOT NULL
            ,last_updated_by VARCHAR(20) NOT NULL DEFAULT "SYSTEM"
            ,last_update_date DATE NOT NULL
        
        ,CONSTRAINT pk_lines PRIMARY KEY (line_id)
        ,CONSTRAINT fk_lines FOREIGN KEY (invoice_id) REFERENCES tb_invoice(invoice_id)
        
        );
