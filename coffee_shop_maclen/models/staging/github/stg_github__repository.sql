with source as (
  select * from {{ source('github', 'repository') }}
),

renamed as (
  select
    id as repository_id,
    owner_id as owner_user_id,

    archived as is_archived,
    default_branch,
    description,
    fork,
    full_name,
    homepage,
    language,
    name,
    private,
    stargazers_count
    
    created_at,

    _fivetran_synced

  from source
)

select * from renamed