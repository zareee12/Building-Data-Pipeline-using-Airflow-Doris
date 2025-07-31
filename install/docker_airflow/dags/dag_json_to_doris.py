from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.models import Variable
from airflow.operators.empty import EmptyOperator
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from datetime import datetime, timedelta
import pendulum


param = Variable.get('dag_json_to_doris', deserialize_json=True)
shell_path=param['shell_path']
items = [
        "identification",
        "market_data",
        "metadata",
        "price_change",
        "supply_data"
    ]

args = {
    'owner': 'reza',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}


with DAG(
    dag_id="dag_json_to_doris",
    default_args=args,
    start_date=datetime(2025, 7, 7),
    schedule_interval=None,
    catchup=False,
    tags=["example"],
) as dag:

    task_start = EmptyOperator(
        task_id="task_start"
    )


    task_end = EmptyOperator(
        task_id="task_end"
    )

    task_src_to_stg = BashOperator(
        task_id=f"task_json_to_doris",
        bash_command=f"sh {shell_path}/json_to_raw.sh ",
    )

    for item in items:

        task_truncate = SQLExecuteQueryOperator(
            task_id = f"truncate_{item}",
            sql = f"truncate table raw.{item}",
            conn_id = "mysql_doris_conn",
        )
        
        task_start >> task_truncate  >> task_src_to_stg >> task_end