CREATE TABLE IF NOT EXISTS tblcity (
    pk_cityid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    cityname VARCHAR(25) UNIQUE NOT NULL,
    PRIMARY KEY (pk_cityid)
);

CREATE TABLE IF NOT EXISTS tblstate (
    pk_stateid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    state VARCHAR(2) UNIQUE NOT NULL DEFAULT 'NY',
    PRIMARY KEY (pk_stateid)
);

CREATE TABLE IF NOT EXISTS tblzipcode (
    pk_zipcodeid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    zipcode INTEGER UNSIGNED UNIQUE NOT NULL,
    PRIMARY KEY (pk_zipcodeid)
);

CREATE TABLE IF NOT EXISTS tblphonetype (
    pk_phonetypeid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    phonetype VARCHAR(12) NOT NULL,
    PRIMARY KEY (pk_phonetypeid)
);

CREATE TABLE IF NOT EXISTS tblitemcategory (
    pk_itemcategoryid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    itemcategory VARCHAR(25) UNIQUE NOT NULL,
    servings_point INTEGER UNSIGNED,
    servings_person_day INTEGER UNSIGNED,
    PRIMARY KEY (pk_itemcategoryid)
);

CREATE TABLE IF NOT EXISTS tblholiday (
    pk_holidayid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    holiday VARCHAR(25) UNIQUE NOT NULL,
    PRIMARY KEY (pk_holidayid)
);

CREATE TABLE IF NOT EXISTS tbldistributionlist (
    pk_distributionlistid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    startdate DATE NOT NULL,
    enddate DATE,
    PRIMARY KEY (pk_distributionlistid)
);

CREATE TABLE IF NOT EXISTS tblstorage (
    pk_storageid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    storagetype VARCHAR(25) NOT NULL,
    PRIMARY KEY (pk_storageid)
);

CREATE TABLE IF NOT EXISTS tblinventory (
    pk_inventoryid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    date DATE,
    PRIMARY KEY (pk_inventoryid)
);

CREATE TABLE IF NOT EXISTS tblclientname (
    pk_clientnameid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    clientlastname VARCHAR(25) NOT NULL,
    clientfirstname VARCHAR(25) NOT NULL,
    clientbirthday DATE NOT NULL,
    enrolldate DATE NOT NULL,
    PRIMARY KEY (pk_clientnameid)
);

CREATE TABLE IF NOT EXISTS tblphone (
    pk_phoneid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_phonetypeid INTEGER UNSIGNED NOT NULL,
    phonenumber VARCHAR(12) UNIQUE NOT NULL,
    phoneextension VARCHAR(10),
    PRIMARY KEY (pk_phoneid),
    FOREIGN KEY (fk_phonetypeid)
        REFERENCES tblphonetype (pk_phonetypeid)
);

CREATE TABLE IF NOT EXISTS tblclientinformation (
    pk_clientinformationid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_clientnameid INTEGER UNSIGNED NOT NULL,
    streetaddress VARCHAR(50) NOT NULL,
    mailingaddress VARCHAR(50) NOT NULL,
    fk_cityid INTEGER UNSIGNED NOT NULL,
    fk_stateid INTEGER UNSIGNED NOT NULL,
    fk_zipcodeid INTEGER UNSIGNED NOT NULL,
    schooldistrict VARCHAR(50) DEFAULT 'Thousand Islands Central School District',
    addressverified BOOLEAN DEFAULT 0,
    incomeverified BOOLEAN DEFAULT 0,
    stove BOOLEAN DEFAULT 0,
    refrigerator BOOLEAN DEFAULT 0,
    microwave BOOLEAN DEFAULT 0,
    canopener BOOLEAN DEFAULT 0,
    snap BOOLEAN DEFAULT 0,
    wic BOOLEAN DEFAULT 0,
    heap BOOLEAN DEFAULT 0,
    unemployment BOOLEAN DEFAULT 0,
    disability BOOLEAN DEFAULT 0,
    ssi BOOLEAN DEFAULT 0,
    refersnap BOOLEAN DEFAULT 0,
    referwic BOOLEAN DEFAULT 0,
    referheap BOOLEAN DEFAULT 0,
    referhealthinsurance BOOLEAN DEFAULT 0,
    referchildnutrition BOOLEAN DEFAULT 0,
    dss BOOLEAN DEFAULT 0,
    foodrestrictions VARCHAR(200),
    staffalert VARCHAR(200),
    editdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (pk_clientinformationid),
    FOREIGN KEY (fk_clientnameid)
        REFERENCES tblclientname (pk_clientnameid),
    FOREIGN KEY (fk_cityid)
        REFERENCES tblcity (pk_cityid),
    FOREIGN KEY (fk_stateid)
        REFERENCES tblstate (pk_stateid),
    FOREIGN KEY (fk_zipcodeid)
        REFERENCES tblzipcode (pk_zipcodeid)
);



CREATE TABLE IF NOT EXISTS tblitemsubcategory (
    pk_itemsubcategoryid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_itemcategoryid INTEGER UNSIGNED NOT NULL,
    itemsubcategory VARCHAR(20) NOT NULL,
    PRIMARY KEY (pk_itemsubcategoryid),
    FOREIGN KEY (fk_itemcategoryid)
        REFERENCES tblitemcategory (pk_itemcategoryid)
);

CREATE TABLE IF NOT EXISTS tbldistributionrequirements (
    pk_distributionrequirementsid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_itemcategoryid INTEGER UNSIGNED NOT NULL,
    qty1 INTEGER UNSIGNED,
    qty2 INTEGER UNSIGNED,
    qty3 INTEGER UNSIGNED,
    qty4 INTEGER UNSIGNED,
    qty5 INTEGER UNSIGNED,
    qty6 INTEGER UNSIGNED,
    qty7 INTEGER UNSIGNED,
    qty8 INTEGER UNSIGNED,
    qty9 INTEGER UNSIGNED,
    qty10 INTEGER UNSIGNED,
    dateactive DATE,
    daterescinded DATE,
    numbermeals VARCHAR(20),
    PRIMARY KEY (pk_distributionrequirementsid),
    FOREIGN KEY (fk_itemcategoryid)
        REFERENCES tblitemcategory (pk_itemcategoryid)
);

CREATE TABLE IF NOT EXISTS tblfamily (
    pk_familyid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_clientnameid INTEGER UNSIGNED NOT NULL,
    familymembername VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    authorized BOOLEAN DEFAULT 0,
    addressverified BOOLEAN DEFAULT 0,
    startdate DATE NOT NULL,
    enddate DATE,
    PRIMARY KEY (pk_familyid),
    FOREIGN KEY (fk_clientnameid)
        REFERENCES tblclientname (pk_clientnameid)
);


CREATE TABLE IF NOT EXISTS tbldistributionitemsub (
    pk_distributionitemsubid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_itemsubcategoryid INTEGER UNSIGNED NOT NULL,
    qty1 INTEGER UNSIGNED,
    qty2 INTEGER UNSIGNED,
    qty3 INTEGER UNSIGNED,
    qty4 INTEGER UNSIGNED,
    qty5 INTEGER UNSIGNED,
    qty6 INTEGER UNSIGNED,
    qty7 INTEGER UNSIGNED,
    qty8 INTEGER UNSIGNED,
    qty9 INTEGER UNSIGNED,
    qty10 INTEGER UNSIGNED,
    PRIMARY KEY (pk_distributionitemsubid),
    FOREIGN KEY (fk_itemsubcategoryid)
        REFERENCES tblitemsubcategory (pk_itemsubcategoryid)
);

CREATE TABLE IF NOT EXISTS tblholidayvoucher (
    pk_holidayvoucherid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_holidayid INTEGER UNSIGNED NOT NULL,
    holidayamount DECIMAL(4 , 2 ) NOT NULL,
    holidaystartdate DATE NOT NULL,
    holidayenddate DATE NOT NULL,
    PRIMARY KEY (pk_holidayvoucherid),
    FOREIGN KEY (fk_holidayid)
        REFERENCES tblholiday (pk_holidayid)
);

CREATE TABLE IF NOT EXISTS tblholidayvoucherdistributed (
    pk_holidayvoucherserial INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_clientnameid INTEGER UNSIGNED NOT NULL,
    voucheramount DECIMAL(4 , 2 ),
    voucherdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    vouchercashed DECIMAL(4 , 2 ),
    PRIMARY KEY (pk_holidayvoucherserial),
    FOREIGN KEY (fk_clientnameid)
        REFERENCES tblclientname (pk_clientnameid)
);

CREATE TABLE IF NOT EXISTS tblitem (
    pk_itemid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    itemname VARCHAR(20) NOT NULL,
    itemsize VARCHAR(20),
    itempointvalue INTEGER UNSIGNED,
    fk_itemsubcategoryid INTEGER UNSIGNED NOT NULL,
    fk_storageid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (pk_itemid),
    FOREIGN KEY (fk_itemsubcategoryid)
        REFERENCES tblitemsubcategory (pk_itemsubcategoryid),
    FOREIGN KEY (fk_storageid)
        REFERENCES tblstorage (pk_storageid)
);

CREATE TABLE IF NOT EXISTS tblinventoryjoinitem (
    fk_inventoryid INTEGER UNSIGNED NOT NULL,
    fk_itemid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (fk_inventoryid , fk_itemid),
    FOREIGN KEY (fk_inventoryid)
        REFERENCES tblinventory (pk_inventoryid),
    FOREIGN KEY (fk_itemid)
        REFERENCES tblitem (pk_itemid)
);

CREATE TABLE IF NOT EXISTS tblvoucherdistribution (
    pk_voucherserial INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    voucherdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    voucheramount DECIMAL(4 , 2 ),
    vouchercashed DECIMAL(4 , 2 ),
    fk_clientnameid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (pk_voucherserial),
    FOREIGN KEY (fk_clientnameid)
        REFERENCES tblclientname (pk_clientnameid)
);

CREATE TABLE IF NOT EXISTS tblvouchervalue (
    pk_vouchervalueid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    voucherbasevalue DOUBLE NOT NULL,
    voucheraddvalue DOUBLE NOT NULL,
    voucherstartdate DATE NOT NULL,
    voucherenddate DATE NOT NULL,
    PRIMARY KEY (pk_vouchervalueid)
);

CREATE TABLE IF NOT EXISTS tblclienttophonejoin (
    fk_clientnameid INTEGER UNSIGNED NOT NULL,
    fk_phoneid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (fk_clientnameid , fk_phoneid),
    FOREIGN KEY (fk_clientnameid)
        REFERENCES tblclientname (pk_clientnameid),
    FOREIGN KEY (fk_phoneid)
        REFERENCES tblphone (pk_phoneid)
);

CREATE TABLE IF NOT EXISTS tblpoc (
    pk_pocid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    pocname VARCHAR(50) NOT NULL,
    pocaddress VARCHAR(50),
    notes VARCHAR(100),
    fk_cityid INTEGER UNSIGNED NOT NULL,
    fk_stateid INTEGER UNSIGNED NOT NULL,
    fk_zipcodeid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (pk_pocid),
    FOREIGN KEY (fk_cityid)
        REFERENCES tblcity (pk_cityid),
    FOREIGN KEY (fk_stateid)
        REFERENCES tblstate (pk_stateid),
    FOREIGN KEY (fk_zipcodeid)
        REFERENCES tblzipcode (pk_zipcodeid)
);

CREATE TABLE IF NOT EXISTS tblpoctophonejoin (
    fk_pocid INTEGER UNSIGNED NOT NULL,
    fk_phoneid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (fk_pocid , fk_phoneid),
    FOREIGN KEY (fk_pocid)
        REFERENCES tblpoc (pk_pocid),
    FOREIGN KEY (fk_phoneid)
        REFERENCES tblphone (pk_phoneid)
);

CREATE TABLE IF NOT EXISTS tbldonors (
    pk_donorid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    donorname VARCHAR(50) NOT NULL,
    donoraddress VARCHAR(50),
    donornotes VARCHAR(100),
    fk_cityid INTEGER UNSIGNED NOT NULL,
    fk_stateid INTEGER UNSIGNED NOT NULL,
    fk_zipcodeid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (pk_donorid),
    FOREIGN KEY (fk_cityid)
        REFERENCES tblcity (pk_cityid),
    FOREIGN KEY (fk_stateid)
        REFERENCES tblstate (pk_stateid),
    FOREIGN KEY (fk_zipcodeid)
        REFERENCES tblzipcode (pk_zipcodeid)
);

CREATE TABLE IF NOT EXISTS tbldonortopocjoin (
    fk_donorid INTEGER UNSIGNED NOT NULL,
    fk_pocid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (fk_donorid , fk_pocid),
    FOREIGN KEY (fk_donorid)
        REFERENCES tbldonors (pk_donorid),
    FOREIGN KEY (fk_pocid)
        REFERENCES tblpoc (pk_pocid)
);

CREATE TABLE IF NOT EXISTS tblsuppliers (
    pk_supplierid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    suppliername VARCHAR(50) NOT NULL,
    supplieraddress VARCHAR(50) NOT NULL,
    fk_cityid INTEGER UNSIGNED NOT NULL,
    fk_stateid INTEGER UNSIGNED NOT NULL,
    fk_zipcodeid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (pk_supplierid),
    FOREIGN KEY (fk_cityid)
        REFERENCES tblcity (pk_cityid),
    FOREIGN KEY (fk_stateid)
        REFERENCES tblstate (pk_stateid),
    FOREIGN KEY (fk_zipcodeid)
        REFERENCES tblzipcode (pk_zipcodeid)
);

CREATE TABLE IF NOT EXISTS tblsuppliertopocjoin (
    fk_suppliersid INTEGER UNSIGNED NOT NULL,
    fk_pocid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (fk_suppliersid , fk_pocid),
    FOREIGN KEY (fk_suppliersid)
        REFERENCES tblsuppliers (pk_supplierid),
    FOREIGN KEY (fk_pocid)
        REFERENCES tblpoc (pk_pocid)
);

CREATE TABLE IF NOT EXISTS tblorders (
    pk_orderid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_supplierid INTEGER UNSIGNED NOT NULL,
    supplierorderid VARCHAR(20),
    orderdate DATE,
    orderreceived DATE,
    PRIMARY KEY (pk_orderid),
    FOREIGN KEY (fk_supplierid)
        REFERENCES tblsuppliers (pk_supplierid)
);

CREATE TABLE IF NOT EXISTS tbldistributionlistjoinitem (
    fk_distributionlistid INTEGER UNSIGNED NOT NULL,
    fk_distributionitemsubid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (fk_distributionlistid , fk_distributionitemsubid),
    FOREIGN KEY (fk_distributionlistid)
        REFERENCES tbldistributionlist (pk_distributionlistid),
    FOREIGN KEY (fk_distributionitemsubid)
        REFERENCES tbldistributionitemsub (pk_distributionitemsubid)
);

CREATE TABLE IF NOT EXISTS tblgrant (
    pk_grantid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    grantname VARCHAR(50) NOT NULL,
    grantamount DECIMAL(10 , 2 ) NOT NULL,
    datereceived DATE,
    usebydate DATE,
    reportrequirements VARCHAR(100),
    reportinterval VARCHAR(25),
    fk_donorid INTEGER UNSIGNED NOT NULL,
    notes VARCHAR(100),
    PRIMARY KEY (pk_grantid),
    FOREIGN KEY (fk_donorid)
        REFERENCES tbldonors (pk_donorid)
);

CREATE TABLE IF NOT EXISTS tblgranttoitemjoin (
    fk_grantid INTEGER UNSIGNED NOT NULL,
    fk_itemcategoryid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (fk_grantid , fk_itemcategoryid),
    FOREIGN KEY (fk_grantid)
        REFERENCES tblgrant (pk_grantid),
    FOREIGN KEY (fk_itemcategoryid)
        REFERENCES tblitemcategory (pk_itemcategoryid)
);

CREATE TABLE IF NOT EXISTS tblgranttosuppliersjoin (
    fk_grantid INTEGER UNSIGNED NOT NULL,
    fk_supplierid INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (fk_grantid , fk_supplierid),
    FOREIGN KEY (fk_grantid)
        REFERENCES tblgrant (pk_grantid),
    FOREIGN KEY (fk_supplierid)
        REFERENCES tblsuppliers (pk_supplierid)
);

CREATE TABLE IF NOT EXISTS tblorderlineitem (
    pk_orderlineitemid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_orderid INTEGER UNSIGNED NOT NULL,
    fk_itemid INTEGER UNSIGNED NOT NULL,
    itemcost DECIMAL(10 , 2 ),
    itempackageqty INTEGER UNSIGNED,
    qtyordered INTEGER UNSIGNED,
    qtyreceived INTEGER UNSIGNED,
    PRIMARY KEY (pk_orderlineitemid),
    FOREIGN KEY (fk_orderid)
        REFERENCES tblorders (pk_orderid),
    FOREIGN KEY (fk_itemid)
        REFERENCES tblitem (pk_itemid)
);

CREATE TABLE IF NOT EXISTS tblgranttoorderlineitemjoin (
    fk_orderlineitemid INTEGER UNSIGNED NOT NULL,
    fk_grantid INTEGER UNSIGNED NOT NULL,
    amountused DECIMAL(10 , 2 ),
    PRIMARY KEY (fk_orderlineitemid , fk_grantid),
    FOREIGN KEY (fk_orderlineitemid)
        REFERENCES tblorderlineitem (pk_orderlineitemid),
    FOREIGN KEY (fk_grantid)
        REFERENCES tblgrant (pk_grantid)
);

CREATE TABLE IF NOT EXISTS tblauthorizedtopickup (
    pk_authorizedtopickupid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_clientnameid INTEGER UNSIGNED NOT NULL,
    authorizedname VARCHAR(50) NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE,
    authorizedforvoucher BOOLEAN DEFAULT 0,
    PRIMARY KEY (pk_authorizedtopickupid),
    FOREIGN KEY (fk_clientnameid)
        REFERENCES tblclientname (pk_clientnameid)
);

CREATE TABLE IF NOT EXISTS tbldistributionevent (
    pk_distributioneventid INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    fk_clientnameid INTEGER UNSIGNED NOT NULL,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    groupsize INTEGER UNSIGNED,
    fk_familyid INTEGER UNSIGNED,
    fk_authorizedtopickupid INTEGER UNSIGNED,
    PRIMARY KEY (pk_distributioneventid),
    FOREIGN KEY (fk_clientnameid)
        REFERENCES tblclientname (pk_clientnameid),
    FOREIGN KEY (fk_familyid)
        REFERENCES tblfamily (pk_familyid),
    FOREIGN KEY (fk_authorizedtopickupid)
        REFERENCES tblauthorizedtopickup (pk_authorizedtopickupid)
);