from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.empty import EmptyOperator
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.models import Variable
from datetime import datetime, timedelta
import os

## List target tables

TABLES = ["coingecko_flat"] 

MYSQL_CONN = "mysql_doris_conn"

param = Variable.get("dag_raw_to_refined", deserialize_json=True) 

path_dir = param['path_dir']

def read_sql_file(table_name, **context):

    sql_file = os.path.join(path_dir, f"table_{table_name}.sql")
    with open(sql_file, 'r') as f:
        sql = f.read()
    # push SQL to XCom
    return sql


args = {
    'owner': 'reza',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    dag_id="dag_raw_to_refined",
    default_args=args,
    start_date=datetime(2025, 7, 8),
    schedule_interval=None,
    catchup=False,
    tags=["example"],
) as dag:

    start = EmptyOperator(task_id="start")
    for table in TABLES:

        trunc_tbl = SQLExecuteQueryOperator(
            task_id=f"truncate_{table}",
            sql="truncate table refined.%s" % table,
            conn_id=MYSQL_CONN,
        )

        read_sql = PythonOperator(
            task_id=f"read_sql_{table}",
            python_callable=read_sql_file,
            op_args=[table],
            provide_context=True,
        )

        exec_sql = SQLExecuteQueryOperator(
            task_id=f"exec_sql_{table}",
            sql="{{ ti.xcom_pull(task_ids='read_sql_%s') }}" % table,
            conn_id=MYSQL_CONN,
        )

        start >> trunc_tbl >> read_sql >> exec_sql
