module Types
  class MutationType < Types::BaseObject
    field :create_organization, mutation: Mutations::Organizations::CreateOrganization do
      description 'Create an organization belonging to a user'
    end

    field :update_organization, mutation: Mutations::Organizations::CreateOrganization do
      description 'Update an organization belonging to a user'
    end

    field :destroy_organization, mutation: Mutations::Organizations::CreateOrganization do
      description 'Destroy an organization belonging to a user'
    end

    field :create_event, mutation: Mutations::Events::CreateEvent do
      description 'Create an event belonging to a tour'
    end

    field :update_event, mutation: Mutations::Events::UpdateEvent do
      description 'Update an event belonging to a tour'
    end

    field :destroy_event, mutation: Mutations::Events::UpdateEvent do
      description 'Destroy an event'
    end

    field :create_tour, mutation: Mutations::Tours::CreateTour do
      description 'Create a tour belonging to an organization'
    end
  end
end
