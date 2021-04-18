module Types
  class MutationType < Types::BaseObject
    field :create_organization, mutation: Mutations::Organizations::CreateOrganization do
      description 'Create an organization belonging to a user'
    end

    field :update_organization, mutation: Mutations::Organizations::UpdateOrganization do
      description 'Update an organization'
    end

    field :destroy_organization, mutation: Mutations::Organizations::DestroyOrganization do
      description 'Destroy an organization'
    end

    field :create_event, mutation: Mutations::Events::CreateEvent do
      description 'Create an event belonging to a tour'
    end

    field :update_event, mutation: Mutations::Events::UpdateEvent do
      description 'Update an event'
    end

    field :destroy_event, mutation: Mutations::Events::DestroyEvent do
      description 'Destroy an event'
    end

    field :create_tour, mutation: Mutations::Tours::CreateTour do
      description 'Create a tour belonging to an organization'
    end

    field :update_tour, mutation: Mutations::Tours::UpdateTour do
      description 'Update a tour'
    end

    field :destroy_tour, mutation: Mutations::Tours::DestroyTour do
      description 'Destroy a tour'
    end

    field :create_contact, mutation: Mutations::Contacts::CreateContact do
      description 'Create a contact belonging to a user'
    end

    field :update_contact, mutation: Mutations::Contacts::UpdateContact do
      description 'Update a contact'
    end

    field :destroy_contact, mutation: Mutations::Contacts::DestroyContact do
      description 'Destroy a contact'
    end
  end
end
