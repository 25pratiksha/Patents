from __future__ import print_function
import patsy
import numpy as np
import pandas as pd
import statsmodels.api as sm
import statsmodels.formula.api as smf
import matplotlib.pyplot as plt
from statsmodels.regression.quantile_regression import QuantReg

cola
['Yearsfounded', 'REVENUE2016', 'NOMINALKAPITAL', 'AREA_INCOME']
data=dt[cola]
data.head()

data=data.dropna(axis='rows')

mod = smf.quantreg('NOMINALKAPITAL ~ Yearsfounded + REVENUE2016 + AREA_INCOME',data)
res = mod.fit(q=.5)
print(res.summary())


quantiles = np.arange(.05, .96, .1)

def fit_model(q):
    res = mod.fit(q=q)
    return [q, res.params['Intercept'], res.params['REVENUE2016'],res.params['Yearsfounded'],res.params['AREA_INCOME']] + \
            res.conf_int().ix['REVENUE2016'].tolist() + \
            res.conf_int().ix['Yearsfounded'].tolist()  + \
            res.conf_int().ix['AREA_INCOME'].tolist()
models = [fit_model(x) for x in quantiles]
models = pd.DataFrame(models, columns=['q', 'a', 'b','c','d', 'lb', 'ub','lc','uc','ld','ud'])
ols = smf.ols('NOMINALKAPITAL ~ REVENUE2016 + Yearsfounded + AREA_INCOME', data).fit()
ols_ci = ols.conf_int().ix['REVENUE2016'].tolist()
ols_di = ols.conf_int().ix['Yearsfounded'].tolist()
ols_ei = ols.conf_int().ix['AREA_INCOME'].tolist()
ols = dict(a=ols.params['Intercept'],
           b=ols.params['REVENUE2016'],
           c=ols.params['Yearsfounded'],
           d=ols.params['AREA_INCOME'],
           lb=ols_ci[0],
           ub=ols_ci[1],
           lc=ols_di[0],
           uc=ols_di[1],
           ld=ols_ei[0],
           ud=ols_ei[1])
print(models)
print(ols)


get_y = lambda a, b, c, d: a+ + b*x + c*x + d*x

fig, ax = plt.subplots(figsize=(8, 6))

for i in range(models.shape[0]):
    y = get_y(models.a[i], models.b[i],models.c[i],models.d[i])
    ax.plot(x, y, linestyle='dotted', color='grey')

y = get_y(ols['a'], ols['b'], ols['c'],ols['d'])

ax.plot(x, y, color='red', label='OLS')
#ax.scatter(data.income, data.foodexp, alpha=.2)
#ax.set_xlim((240, 3000))
#ax.set_ylim((240, 2000))
legend = ax.legend()
ax.set_xlabel('Income', fontsize=16)
ax.set_ylabel('Food expenditure', fontsize=16);
