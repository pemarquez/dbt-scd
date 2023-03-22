{% snapshot snap_users_hist %}

{{
    config(
        target_schema="snapshot",
        unique_key="concat(id, updated_at)",
        strategy="timestamp",
        updated_at="updated_at",
    )
}}

select *
from {{ ref("raw_user") }}

{% endsnapshot %}
