<script
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
  type="text/javascript">
</script>

### About

This is a home insurance ratemaking project using a sample dataset of around 500 claims and 2400 claim transactions, created by the [Actuarial Accelerator Community](https://etchedactuarial.com/accelerator) for educational purposes. The claims are reported by home insurers from 2018 to 2025 for losses involving wind/hail, water damage, fire, flood, and theft under policies covered by the Etched Actuarial Home Insurance Inc (EAHII). 

This project aims to do the following:
1. **Compute the ultimate losses projected from the most recent payments from EAHII made in 2025 using the chain-ladder technique.** The ultimate losses are computed as an average of the average loss development factors and the industry benchmark factors weighted by a credibility factor, from the given claims data and derives the selected ultimate development factor  used to project the total ultimate losses.
2. **Visualize the trends of payments in aggregation.** Two line charts are used: one aggregating payments against claims' accident years, and another aggregating against claims' payment months. These aggregates are categorized by claim type.
3. **Identify premium rate changes allowed by EAHII and Property Insurance Regulators, using the data on total premiums and ultimate losses from the payments made in 2025 on open claims.** An aggregate premium rate change is allowed by EAHII if for each claim type, the resulting after-adjustment loss ratio, computed as
$$ \text{after-adjustment loss ratio} = \frac{\text{current ultimate losses}}{(\text{current premiums})(1+\text{premium rate change})} $$
doesn't fall outside of 10% of the target loss ratio; it is allowed by the regulators if it is within their error rate (for instance, if it is 5%, then premium rate changes must be less than or equal to 5% up or down).

This project is done **twice**: Once in Excel, and the other using a combination of SQL/Python.

### How to use

```
    .
    ├── data/
    │   ├── claim_payments.csv
    │   ├── claims.csv
    │   └── industry_benchmark_factors.csv
    ├── reports/
    │   ├── home insurance ratemaking.ipynb
    │   ├── analysis.sql
    │   └── home insurance ratemaking.xlsm
    ├── scripts/
    │   ├── data.bas
    │   └── database.sql
    └── requirements.txt
```

#### Excel

Simply download the file `reports/home insurance ratemaking.xlsm` and open it in Excel. Make sure to enable macros.

Note that the excel file contains the following worksheets:
- **Loss Calculator**: Computes the total ultimate losses from claims data and industry benchmarks for each claim type (as an input). 
- **Aggregate payments analysis**: Shows the trends of claim payments over time as a line graph. 
- **Premium change analysis**: Computes (via a macro) which rate changes on premium (as percentages) are allowed by EAHII and their regulator, given the following inputs: target loss ratios for each claim type, as well as error rates (as percentages) for EAHII and the regulator. 

The rest of the worksheets are the data:
- **1. ENC - Home Dataset**: All claims and their transactions.
- **2. Index**: A summary of industry benchmark loss development factors of each claim type.
- **3. Theft**: Age-to-age industry loss development factors for losses involving theft.
- **4. Wind/Hail**: Age-to-age industry loss development factors for losses involving wind/hail.
- **5. Water_Damage**: Age-to-age industry loss development factors for losses involving water damage.
- **6. Flood**: Age-to-age industry loss development factors for losses involving flooding.
- **7. Fire**: Age-to-age industry loss development factors for losses involving fire.

#### SQL / Python

The SQL portion of this project is simply located in `reports/analysis.sql` and utilizes a database, which can be set up using the `csv` files in `data/` as well as the `scripts/database.sql` file. It's recommended to use MySQL Workbench 8.0+ so as to use the `LOAD DATA INFILE` commands in `scripts/database.sql`.

The file `reports/analysis.sql` simply queries information about data `claims.csv` and `claim_payments.csv`, such as the number of claim payments per claim type, and identifies those claims whose total payments go over $250,000.

The Python portion of this project basically recreates what has been done in Excel. The majority of the code can be found in `reports/home insurance ratemaking.ipynb` as a notebook. To run this notebook, you can either download [Anaconda](https://www.anaconda.com/download) and run Jupyter with it, or you can do the following:

1. Set up a Python 3.13.2 environment in the project folder with the following terminal commands:
```
    python3 -m venv env
    source env/bin/activate
    pip3 install --upgrade pip
    pip3 install -r requirements.txt
    deactivate
```

2. Open up VS Code, add the project folder into your Workspace, open up `reports/home insurance ratemaking.ipynb` and set your kernel to be `env/bin/python` that you just built from the previous step.

3. Run the commands in each cell!

#### Other

This project was originally suited to be built in Excel, so I've extracted the data from the original `.xlsx` file using Excel itself and a bit of VBA (in `scripts/data.bas`, used to format `data/claim_payments.csv`). 