module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser do
      description 'Create a user'
    end

    field :update_user, mutation: Mutations::Users::UpdateUser do
      description 'Update a user'
    end

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

    field :create_sub_event, mutation: Mutations::SubEvents::CreateSubEvent do
      description 'Create a sub event belonging to an event'
    end

    field :update_sub_event, mutation: Mutations::SubEvents::UpdateSubEvent do
      description 'Update a subEvent'
    end

    field :destroy_sub_event, mutation: Mutations::SubEvents::DestroySubEvent do
      description 'Destroy a subEvent'
    end

    field :create_venue, mutation: Mutations::Venues::CreateVenue do
      description 'Create a venue'
    end

    field :update_venue, mutation: Mutations::Venues::UpdateVenue do
      description 'Update a venue'
    end

    field :destroy_venue, mutation: Mutations::Venues::DestroyVenue do
      description 'Destroy a venue'
    end
  end
end
