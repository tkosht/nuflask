from flask import Flask
import pandas as pd
from fbprophet import Prophet
from fbprophet.plot import plot_plotly
import datetime
# import plotly.offline as py

app = Flask(__name__)


@app.route("/")
def hello():
    dt_now = datetime.datetime.now()
    message = f"Hello World @ {dt_now}"
    return message


@app.route("/prophet")
def prophet():
    df = pd.read_csv('data/example_wp_log_peyton_manning.csv')
    m = Prophet()
    m.fit(df)

    future = m.make_future_dataframe(periods=365)
    forecast = m.predict(future)
    # fig = plot_plotly(m, forecast)  # This returns a plotly Figure
    # py.iplot(fig)
    return "OK"


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=80)
