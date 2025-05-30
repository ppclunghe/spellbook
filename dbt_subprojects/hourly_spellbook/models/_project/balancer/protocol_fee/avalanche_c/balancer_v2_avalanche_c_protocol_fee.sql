{% set blockchain = 'avalanche_c' %}

{{
    config(
        schema = 'balancer_v2_avalanche_c',
        alias = 'protocol_fee', 
        materialized = 'table',
        file_format = 'delta'
    )
}}

{{ 
    balancer_v2_compatible_protocol_fee_macro(
        blockchain = blockchain,
        version = '2',        
        project_decoded_as = 'balancer_v2',
        base_spells_namespace = 'balancer',
        pool_labels_spell =  source('labels', 'balancer_v2_pools') 
    )
}}
