"""
To store reusable constants (e.g., headers, cost centers mapping etc)

Copyright (C) Weicong Kong, 2/09/2021
"""

# mk: yes it does. I ust have to run SELECT DISTINCT to get a list of cost centres, accounting_codes,

cc = '99'

CATEGORY = 'category'

ACCOUNT_DESC = 'account_description'

ACCOUNT_CODE = 'account_code'

ALT_PRODUCT_GROUP = 'alt_product_group'

SALES_CODE = '300000'

COGS_CODE = '400000'

PROD_LIST = ['retail', 'commercial', 'tuffa', 'oil', 'hire', 'process_chemical']

COST_CENTER_LIST = ['11', '21', '95', '14', '24', '96', '29', '30', '104', '19', '40', '102', '31', '33', '106', '44',
                    '22', '109', '38', '39', '105']

DIV_LIST = ['sales', 'manufacturing', 'supply chain', 'engineering', 'corporate', 'quality & safety', 'marketing']

LOCATIONS = ['lae', 'pom']

CATEGORIES = ['revenue', 'cogs', 'trading_profit', 'trading_margin', 'manufacturing_variances', 'stock_variances',
              'direct_costs', 'gross_profit', 'overheads', 'other_income', 'other_expenses', 'net_profit']

REVENUE_APGS = ['ACACON', 'ACACOP', 'ACAOIL', 'ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT',
                'ACMCCR', 'ACMMAN', 'ACRSUN', 'ACSALU', 'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSONN', 'ACSOOO', 'ACSSUL',
                'ACTDAZ', 'ACTDHR', 'ACTDLP', 'ACUOIL', 'AIJSAF', 'AIOSEH', 'AIPROT', 'ACBBOT', 'AIJSAF', 'AIOSEH']

COGS_APGS = ['ACACON', 'ACACOP', 'ACAOIL', 'ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACJDOM', 'ACKCOM', 'ACLCAT',
             'ACMCCR', 'ACMMAN', 'ACRSUN', 'ACSALU', 'ACSCAU', 'ACSENV', 'ACSHYD', 'ACSONN', 'ACSOOO', 'ACSSUL',
             'ACTDAZ', 'ACTDHR', 'ACTDLP', 'ACUOIL', 'AIJSAF', 'AIOSEH', 'AIPROT', 'ACBBOT', 'AIJSAF', 'AIOSEH']

MANUFACTURING_VARIANCE_ACCOUNTS = ['400901', '400902', '400903', '400910', '400911', '400916']

STOCK_VARIANCE_ACCOUNTS = ['401000', '401020', '402000']

DIRECT_COSTS = ['AIXAAB', 'AIXCGL', 'AIXCRN', 'AIXDLC', 'AIXFRR', 'AIXFRS', 'AIXFRT', 'AIXFRU', 'AIXPAR', 'AIXROY', ' ']

OVERHEADS_ACCOUNTS = ['530010', '530011', '530020', '530030', '530035', '530040', '530045', '530065', '530080',
                      '530095', '530096', '530101', '530105', '530109', '530120', '530125', '530130', '530145',
                      '530155', '530159', '530160', '530161', '530165', '530170', '530174', '530176', '530177',
                      '530182', '530183', '530184', '530185', '530186', '530188', '530189', '530190', '530191',
                      '530193', '530194', '530195', '530197', '530199', '530200', '530260', '530270', '530275',
                      '530280', '530291', '530295']

OTHER_EXPENSES = ['530215', '530230', '530232', '530234', '530240', '530245', '530249', '530250']

OTHER_INCOME = ['530206']

COMMERCIAL_SALES_LIST = ['ACBBOT', 'ACHCLE', 'ACIKAT', 'ACKCOM', 'ACLCAT', 'ACMMAN', 'ACRSUN', 'ACSALU', 'ACSCAU',
                         'ACSENV', 'ACSHYD', 'ACSOOO', 'AIJSAF', 'ACSSUL', 'ACCFOO']

RETAIL_SALES_LIST = ['ACACON', 'ACACOP', 'ACJDOM', 'ACMCCR', 'ACTDAZ', 'ACTDHR', 'ACTDLP']

OIL_SALES_LIST = ['ACAOIL', 'ACUOIL']

TUFFA_SALES_LIST = ['AIPROT']

HIRE_SALES = ['AIOSEH']

MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October',
          'November', 'December']

CATEGORY1 = 'revenue'
CATEGORY2 = 'cogs'
CATEGORY3 = 'direct_costs'
CATEGORY4 = 'overheads'
CATEGORY5 = 'trading_profit'
CATEGORY6 = 'trading_margin'
CATEGORY7 = 'accounting_code'

LIST = ['accounting_code', 'cc', 'category', 'description', 'alt_product_group']

MONTHS_2020 = {
    'january': 'January_20',
    'february': 'February_20',
    'march': 'March_20',
    'april': 'April_20',
    'may': 'May_20',
    'june': 'June_20',
    'july': 'July_20',
    'august': 'August_20',
    'september': 'September_20',
    'october': 'October_20',
    'november': 'November_20',
    'december': 'December_20'
}

MONTHS_2021 = {
    'january': 'January_21',
    'february': 'February_21',
    'march': 'March_21',
    'april': 'April_21',
    'may': 'May_21',
    'june': 'June_21',
    'july': 'July_21',
    'august': 'August_21',
    'september': 'September_21',
    'october': 'October_21',
    'november': 'November_21',
    'december': 'December_21'
}

TRANSACTION_TYPE = {
    '0': 'Account Balance',  # we will only look at this type
    '1': 'Budget Alternative 1',
    '2': 'Budget Alternative 2',
    '3': 'Budget Alternative 3',
    '4': 'Budget Alternative 4',
    '5': 'Budget Alternative 5',
    '6': 'Previous Year'}

SALES_COST_CENTRES = {
    '11': 'lae_commercial_sales',
    '21': 'pom_commercial_sales',
    '95': 'commercial_consolidated',
    '14': 'lae_retail_sales',
    '24': 'pom_retail_sales',
    '96': 'retail_sales_consolidated',
    '29': 'tuffa_sales_lae',
    '30': 'tuffa_sales_pom',
    '104': 'tuffa_sales_consolidated',
    '19': 'lae_oil_sales',
    '40': 'pom_oil_sales',
    '102': 'oil_sales_consolidated',
    '31': 'pom_equipment_hire',
    '33': 'lae_equipment_hire',
    '106': 'hire_consolidated',
    '44': 'prom_process_chemical',
    '22': 'lae_process_chemical',
    '109': 'process_chemical_consolidated',
    '38': 'lae_plastics_sales',
    '39': 'pom_plastics_sales',
    '105': 'plastics_sales_consolidated'
}

FACTORY_COST_CENTRES = {
    '50': 'chemical_factory',
    '55': 'oil_factory',
    '60': 'plastics_factory',
    '80': 'paper_factory',
    '85': 'tuffa_factory',
    '97': 'manufacturing_consolidated'
}

SUPPLY_CHAIN_COST_CENTRES = {
    '18': 'lae_warehouse',
    '27': 'pom_warehouse',
    '37': 'supply_chain',
    '100': 'supply_chain_consolidated'
}

ENGINEERING_COST_CENTRES = {
    '41': 'fleet_maintenance',
    '46': 'building_maintenance',
    '42': 'factory_engineering',
    '107': 'engineering_consolidated'
}

OTHER_COST_CENTRES = {
    '47': 'QUALITY & SAFETY',
    '90': 'CORPORATE',
    '99': 'COMPANY'
}

APG_DESCRIPTIONS = {
    'ACBBOT': 'PLASTICS BOTTLES & CAPS',
    'ACCFOO': 'FOOD TRAYS',
    'ACHCLE': 'CLEANING ACCESSORIES',
    'ACIKAT': 'DISPENSERS',
    'ACJDOM': 'PAPER DOMESTIC',
    'ACKCOM': 'PAPER COMMERCIAL',
    'ACLCAT': 'CATERING CONSUMABLES',
    'ACMMAN': 'OWN MANUFACTURE CHEMICALS',
    'ACRSUN': 'CHEMICAL SUNDRY SALES',
    'ACSALU': 'ALUMINIUM SULPHATE',
    'ACSCAU': 'CAUSTIC SODA',
    'ACSENV': 'ENVIRO',
    'ACSHYD': 'HYDROCHLORIC ACID',
    'ACSOOO': 'PROCESS CHEMICALS OTHERS',
    'ACTDHR': 'DAZZLE HOUSEHOLD RANGE',
    'AIPROT': 'TUFFA',
    'ACACON': 'CONTRACT BLEACH',
    'ACACOP': 'CONTRACT PAPER',
    'ACMCCR': 'CAR CARE RANGE',
    'ACTDAZ': 'DAZZLE BLEACH',
    'ACTDLP': 'DAZZLE LAUNDRY POWDER',
    'ACAOIL': 'CONTRACT OIL',
    'ACUOIL': 'GOLD N SUN',
    'ACSSUL': 'SULPHURIC ACID',
    'AIJSAF': 'Safety',
    'AIOSEH': 'Hire'
}

MANUFACTURING_VARIANCES_DICT = {
    '400001': 'machine variable recovery',
    '400901': 'material_variance_qty',
    '400902': 'material_variance_value',
    '400903': 'material_variance_combo',
    '400910': 'machine_variance_qty',
    '400911': 'machine_variance_value',
    '400916': 'general differences'
}

STOCK_VARIANCES_DICT = {
    '401000': 'Revaluation',
    '401020': 'SURPLUS & SHORTAGES',
    '402000': 'PPV'
}
DIRECT_COSTS_DICT = {
    'AIXCOS': 'STOCKTAKE GAIN/LOSS',
    'AIXCOT': 'STOCK ADJUSTMENT',
    'AIXFRA': 'TRANSPORT COST (ISOTANKS)',
    'AIXAAB': 'REBATES',
    'AIXAFG': 'PRODUCTION FINISHED GOODS',
    'AIXARM': 'RAW MATERIAL COSTS',
    'AIXCGL': 'COSTINGS GAIN/LOSS',
    'AIXCRN': 'CREDIT NOTES',
    'AIXDLC': 'WAGES DIRECT LABOUR COST',
    'AIXFRR': 'FREIGHT PAID BY KKK',
    'AIXFRS': 'FREIGHT STOCK TRANSFER',
    'AIXFRT': 'FREIGHT TO CUSTOMERS',
    'AIXFRU': 'FREIGHT RECOVERY',
    'AIXPAR': 'EQUIPMENT HIRE PARTS',
    'AIXROY': 'ROYALTIES'
}

OVERHEADS_DICT = {
    '530010': 'advertising_&_marketing',
    '530011': 'gondola_ends',
    '530020': 'computer',
    '530026': 'tax_penalty_fees',
    '530030': 'courier_&_postage',
    '530035': 'depreciation',
    '530040': 'utilities',
    '530043': 'doubtful_debts_staff',
    '530044': 'doubtful_debts_trade',
    '530045': 'entertainment',
    '530065': 'INSURANCE',
    '530080': 'EXTERNAL EQUIPMENT HIRE',
    '530095': 'MOTOR VEHICLE',
    '530096': 'MOTOR VEHICLE HIRE',
    '530097': 'M/VEHICLE-MILAGE RECOVERY',
    '530100': 'LAB/CONSUMABLES & TESTS',
    '530101': 'CUSTOMER DISPENSER FITTIN',
    '530105': 'LICENCES/BADGE/REPORTS',
    '530108': 'PROMOTIONS',
    '530109': 'MKTG PREMIUMS & MERCHANDI',
    '530120': 'PACKAGING MAT/SEALS/TARPS',
    '530125': 'PRINTING & STATIONERY',
    '530130': 'RECRUITMENT&REPATRIATION',
    '530145': 'SAFETY/FIRST AID/UNIFORMS',
    '530146': 'FIRE PROTECTION SAFETY',
    '530155': 'RATES & TAXES',
    '530158': 'CLEANING CONSUMABLES',
    '530159': 'RISK MANAGEMENT PEST CONT',
    '530160': 'RENT EXTERNAL BUILDING',
    '530161': 'CONSUMABLES',
    '530165': 'REPAIRS&MAINT (EXC M/V)',
    '530170': 'SECURITY&COMM.(EXC STAFF)',
    '530174': 'STAFF COST UTILITY CHARGE',
    '530176': 'STAFF COST AMENITIES',
    '530177': 'STAFF TRAINING-NATIONALS',
    '530179': 'STAFF COMMISSION',
    '530182': 'STAFF L.S.L.',
    '530183': 'STAFF N.P.F.',
    '530184': 'STAFF HOUSING ALLOWANCE',
    '530185': 'STAFF SUBSCRIPTION FEES',
    '530186': 'STORAGE',
    '530188': 'STAFF LEAVE AIR FARES',
    '530189': 'STAFF EXT.RENT ACCOMM',
    '530190': 'TELEPHONE',
    '530191': 'STAFF SCHOOL FEES',
    '530193': 'STAFF SALARIES&WAGES-O/H',
    '530194': 'STAFF COST AON CONT',
    '530195': 'TOOLS CONSUMABLES',
    '530197': 'STAFF WAGES RATE ADJ',
    '530199': 'SUBSCRIPTION-COMPANY',
    '530200': 'TRAVEL & ACCOMMODATION',
    '530260': 'CONSULTING FEES',
    '530270': 'WORK PERMIT & VISA FEES',
    '530275': 'TAXATION SERVICES',
    '530280': 'AUDITING SERVICES',
    '530291': 'LEGAL SERVICES',
    '530295': 'ACCOUNTING SERVICES',
}

OTHER_INCOME_DICT = {'530206': 'OTHER INCOME-RENTALS'}

OTHER_EXPENSES_DICT = {
    '530215': 'EXCHANGE-GAIN/-LOSS',
    '530230': 'INTEREST EXPENSE',
    '530232': 'BANK FEES',
    '530234': 'STAMP DUTY FEES',
    '530240': 'LOSS ON DISPOSAL',
    '530243': 'Profit on Disposal',
    '530245': 'COSTED-BANK FEES',
    '530249': 'LICENSING FEE',
    '530250': 'COSTED-MARINE INSURANCE'
}

lae_retail_revenue_reader_list = (14, 'retail', 'sales', 'revenue', 2020, 'lae')

def convert_date_format():
    pass

def convert_currency_symbol():
    pass
