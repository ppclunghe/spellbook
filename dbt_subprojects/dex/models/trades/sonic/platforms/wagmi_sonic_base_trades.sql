{{
    config(
        schema = 'wagmi_sonic',
        alias = 'base_trades',
        materialized = 'incremental',
        file_format = 'delta',
        incremental_strategy = 'merge',
        unique_key = ['tx_hash', 'evt_index'],
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')]
    )
}}

{{
    uniswap_compatible_v3_trades(
        blockchain = 'sonic',
        project = 'wagmi',
        version = '3',
        Pair_evt_Swap = source('wagmi_sonic', 'UniswapV3Pool_evt_Swap'),
        Factory_evt_PoolCreated = source('wagmi_sonic', 'UniswapV3Factory_evt_PoolCreated')
    )
}}