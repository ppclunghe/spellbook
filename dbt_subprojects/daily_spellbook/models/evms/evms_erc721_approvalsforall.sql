{{ config(
        schema='evms',
        alias = 'erc721_approvalsforall',
        unique_key=['blockchain', 'tx_hash', 'evt_index'],
        post_hook='{{ expose_spells(\'["ethereum", "polygon", "bnb", "avalanche_c", "gnosis", "fantom", "optimism", "arbitrum", "celo", "base", "zksync", "zora", "scroll", "linea", "zkevm", "blast", "mantle", "ronin", "ink"]\',
                                    "sector",
                                    "evms",
                                    \'["hildobby"]\') }}'
        )
}}

{% set erc721_approvalforalls_models = [
     ('ethereum', source('erc721_ethereum', 'evt_ApprovalForAll'))
     , ('polygon', source('erc721_polygon', 'evt_ApprovalForAll'))
     , ('bnb', source('erc721_bnb', 'evt_ApprovalForAll'))
     , ('avalanche_c', source('erc721_avalanche_c', 'evt_ApprovalForAll'))
     , ('gnosis', source('erc721_gnosis', 'evt_ApprovalForAll'))
     , ('fantom', source('erc721_fantom', 'evt_ApprovalForAll'))
     , ('optimism', source('erc721_optimism', 'evt_ApprovalForAll'))
     , ('arbitrum', source('erc721_arbitrum', 'evt_ApprovalForAll'))
     , ('celo', source('erc721_celo', 'evt_ApprovalForAll'))
     , ('base', source('erc721_base', 'evt_ApprovalForAll'))
     , ('zksync', source('erc721_zksync', 'evt_ApprovalForAll'))
     , ('zora', source('erc721_zora', 'evt_ApprovalForAll'))
     , ('scroll', source('erc721_scroll', 'evt_ApprovalForAll'))
     , ('linea', source('erc721_linea', 'evt_ApprovalForAll'))
     , ('zkevm', source('erc721_zkevm', 'evt_ApprovalForAll'))
     , ('blast', source('erc721_blast', 'evt_ApprovalForAll'))
     , ('mantle', source('erc721_mantle', 'evt_ApprovalForAll'))
     , ('sei', source('erc721_sei', 'evt_ApprovalForAll'))
     , ('ronin', source('erc721_ronin', 'evt_ApprovalForAll'))
     , ('ink', source('erc721_ink', 'evt_ApprovalForAll'))
     , ('unichain', source('erc721_unichain', 'evt_ApprovalForAll'))
     , ('lens', source('erc721_lens', 'evt_ApprovalForAll'))
] %}

SELECT *
FROM (
        {% for erc721_approvalforalls_model in erc721_approvalforalls_models %}
        SELECT
        '{{ erc721_approvalforalls_model[0] }}' AS blockchain
        , contract_address
        , evt_tx_hash
        , evt_index
        , evt_block_time
        , evt_block_number
        , approved
        , owner
        , operator
        FROM {{ erc721_approvalforalls_model[1] }}
        {% if not loop.last %}
        UNION ALL
        {% endif %}
        {% endfor %}
        );