{{ config(
    schema = 'tokens_solana',
    alias = 'sol_transfers_2021_q4',
    tags = ['static'],
    partition_by = ['block_date'],
    materialized = 'table',
    file_format = 'delta'
) }}

{{ solana_sol_transfers_macro(
    "cast('2021-10-01' as timestamp)",
    "cast('2022-01-01' as timestamp)"
) }} 