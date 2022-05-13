"""

"""
SALES_GROUP_LIST = ['retail', 'oil', 'hire', 'tuffa', 'commercial']

RETAIL_SALES_CCS = ['14', '24']

COMMERCIAL_SALES_CCS = ['11', '21', '38', '44', '22']

HIRE = ['31', '33']

TUFFA_SALES_CCS = ['29', '30']

OIL_SALES_CCS = ['19', '40']

TRANSACTION_TYPE = '01'

FACTORY_COST_CENTERS_LIST = [50, 55, 60, 80, 85]

FACTORY_COST_CENTERS_DICT = {
    '50': 'Chemical Factory',
    '55': 'Oil Factory',
    '60': 'Plastics Factory',
    '80': 'Paper Factory',
    '85': 'Tuffa Factory'
}

UNNEEDED_WAREHOUSES = [1, 2, 3, 4, 5, 6, 9, 10, 14, 27, 70, 71, 74, 75, 81, 82, 83, 90, 91, 92]

FACTORY_WAREHOUSES_LIST = [40, 41, 48, 51, 60]

DROP_LIST = ['accounting_code', 'cc', 'category', 'Group', 'description', 'alt_product_group']

FACTORY_WAREHOUSES_DICT = {
    '40': 'Oil warehouse',
    '41': 'Paper warehouse',
    '48': 'Chemical warehouse',
    '51': 'Tuffa warehouse',
    '60': 'Plastics warehouse'
}

MONTH_LIST = ['January_20', 'February_20', 'March_20', 'April_20', 'May_20', 'June_20',
              'July_20', 'August_20', 'September_20', 'October_20', 'November_20', 'December_20',
              'January_21', 'February_21', 'March_21', 'April_21', 'May_21', 'June_21',
              'July_21', 'August_21', 'September_21', 'October_21', 'November_21', 'December_21']

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

OIL_FACTORY_PRODUCTS = {
    '11-01-0030': 'GNS C/OIL 15LTR YELLOW',
    '11-010026': 'GNS C/OIL 1Lx12PK',
    '11-01-0050': 'GNS C/OIL 200LTR',
    '11-01-0011': 'GNS C/OIL 24X500ML CTN',
    '11-01-0008': 'GNS C/OIL 48X250ML CTN',
    '11-01-0012': 'GNS C/OIL 48X250ML PACK',
    '11-01-0004': 'GNS C/OIL 4PKx4LTR',
    '11-01-0019': 'GNS C/OIL 500MLx24PK',
    '11-01-0025': 'KING C/OIL 15LTR JERRYCAN',
    '11-01-0022': 'KING C/OIL 1L 12 PK S/WRP',
    '11-01-0060': 'KING C/OIL 48X250ML PACK',
    '11-01-0024': 'KING C/OIL 4LTR 4 PCK/CTN',
    '11-01-0021': 'KING C/OIL500ML24PK S/WRP'
}

FULL_COMMERCIAL_APG_DICT = {
    'ACBBOT': 'PLASTICS BOTTLES & CAPS',
    'ACCFOO': 'FOOD TRAYS',
    'ACHCLE': 'CLEANING ACCESSORIES',
    'ACIKAT': 'DISPENSERS',
    'ACKCOM': 'PAPER COMMERCIAL',
    'ACLCAT': 'CATERING CONSUMABLES',
    'ACMMAN': 'OWN MANUFACTURE CHEMICALS',
    'ACRSUN': 'CHEMICAL SUNDRY SALES',
    'ACSALU': 'ALUMINIUM SULPHATE',
    'ACSCAU': 'CAUSTIC SODA',
    'ACSENV': 'ENVIRO',
    'ACSHYD': 'HYDROCHLORIC ACID',
    'ACSOOO': 'PROCESS CHEMICALS OTHERS',
    'ACSSUL': 'SULPHURIC ACID',
    'AIJSAF': 'Safety',
}

# SHORT_COMMERCIAL_APG_DICT = {
#     'ACMMAN': 'OWN MANUFACTURE CHEMICALS',
#     'ACKCOM': 'PAPER COMMERCIAL',
#     ['ACBBOT', 'ACCFOO', 'ACHCLE', 'ACIKAT', 'ACLCAT', 'ACRSUN', 'ACSALU', 'ACSENV', 'ACSHYD', 'ACSOOO', 'ACSSUL',
#      'ACSSUL', 'AIJSAF']: 'other'
# }

RETAIL_APGS = {
    'ACJDOM': 'PAPER DOMESTIC',
    'ACTDHR': 'DAZZLE HOUSEHOLD RANGE',
    'ACACON': 'CONTRACT BLEACH',
    'ACACOP': 'CONTRACT PAPER',
    'ACMCCR': 'CAR CARE RANGE',
    'ACTDAZ': 'DAZZLE BLEACH',
    'ACTDLP': 'DAZZLE LAUNDRY POWDER'
}

TUFFA_APG = {
    'AIPROT': 'TUFFA'
}

OIL_APGS = {
    'ACAOIL': 'CONTRACT OIL',
    'ACUOIL': 'GOLD N SUN'
}

# BLEACH_FACTORY_PRODUCTS = {
# 	'': 'BLEACH 10% 1000L',
# 	'': 'BLEACH 10% 200L',
# 	'': 'BLEACH 10% 20L',
# 	'': 'BLEACH 10% 5L',
# 	'': 'BLEACH 3.5% 200L',
# 	'': 'BLEACH 3.5% 20L',
# 	'': 'BLEACH 3.5% 5L',
# 	'': 'DAZ BLCH 12x750ML W/R',
# 	'': 'DAZ BLEACH 6x1250ML',
# 	'': 'DAZ LEMN BLCH12X200ML W/R',
# 	'': 'DAZ LEMN BLCH12X500ML W/R',
# 	'': 'DAZ LEMN BLCH12X750ML W/R',
# 	'': 'DAZZLE BLCH 12X200ML W/R',
# 	'': 'DAZZLE BLCH 12X500ML W/R',
# 	'': 'KING BLEACH 12X200ML REG',
# 	'': 'KING BLEACH 12X500ML REG'
# 	'': 'KING BLEACH 12X750ML REG',
# 	'': 'KING LEM BLEACH 12x500ML',
# 	'': 'KING LEMON BLEACH12x200ML'
# 	'': 'SUPAKLIN BLEACH 200ML',
# 	'': 'SUPAKLIN BLEACH 500ML'
# }

# TUFFA_FACTORY_PRODUCTS = {
# 	'': 'TUFFA 250L HEADER TANK',
# 	'': 'TUFFA 350L TANK',
# 	'': 'TANK 750L SL PETAL R-GUM',
# 	'': 'TANK 1000 LTR R/GUM GREEN',
# 	'': 'TANK 2000L PETAL R/GUM',
# 	'': 'TANK 3000L PETAL R/GUM',
# 	'': 'TANK 5000L PETAL R/GUM GR',
# 	'': 'TANK 9000L PETAL R/GUM'
# 	'': 'TANK SEPTIC, BLACK 5000L',
# }

# PAPER_FACTORY_PRODUCTS = {
# 	'': 'CITY PHARMACY 2 PLYx160SH',
# 	'': 'COSTSAVER HAND TOWEL',
# 	'': 'DAEWON PREMIUM TOILET',
# 	'': 'DAEWON S/T TOILET ,2 PLY',
# 	'': 'DAEWON S/T TOILET TISSUE',
# 	'': 'DAEWON S/T TOILET TISSUE,',
# 	'': 'DAZZLE 2PLY 130 SHT TWIN',
# 	'': 'DAZZLE 2PLY 130SHT 12PACK',
# 	'': 'DAZZLE 2PLY 130SHT 4 PACK',
# 	'': 'DAZZLE 2PLY 130SHT 6 PACK',
# 	'': 'DAZZLE BIKPELA TOILET',
# 	'': 'DAZZLE KITCHEN TOWEL',
# 	'': 'DAZZLE KITCHEN TOWEL TWIN',
# 	'': 'DAZZLE SINGLE  2PLY 130SH',
# 	'': 'EXECUTIVE T/ROLL',
# 	'': 'GENTLE 2PLY 130SHT 6 PACK',
# 	'': 'GENTLE SINGLE 130SHT 2PLY',
# 	'': 'INSTITUTIONAL T/ROLL',
# 	'': 'JUMBO T/ROLL 6PK',
# 	'': 'KING 2PLY 170 4 PACK',
# 	'': 'KING 2PLY X 170 SINGLE',
# 	'': 'KING 2PLY X 350SH 2 PACK',
# 	'': 'KING 2PLY X 350SH 4 PACK',
# 	'': 'KING 2PLY X 350SH SINGLE',
# 	'': 'KING 2PLYX130SH SINGLE',
# 	'': 'LARGE HAND TOWEL 6PK',
# 	'': 'LIKLIK JUMBO',
# 	'': 'MAXI 225',
# 	'': 'MINI HAND TOWEL',
# 	'': 'MYST TOILET TISSUE X 350',
# 	'': 'MYST TOILET TISSUE x350',
# 	'': 'NATURE SOFT 2PLYX210 4 PA',
# 	'': 'NATURE SOFT 2PLYX210 8 PA',
# 	'': 'NATURE SOFT 2PLYX210 SING',
# 	'': 'NATURE SOFT 2PLYX210 TWIN',
# 	'': 'PAPER T/ROLL CONTRACT',
# 	'': 'PAPER T/ROLL JUMBO',
# 	'': 'PRICE FIGHTER T/ROLL',
# 	'': 'SOFTEE 2PLY X 210 4 PACK',
# 	'': 'SOFTEE 2PLY X 210 SINGLES'
# }
