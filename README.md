# Asset Tracker

## Intoduction

Proof of concept *Asset Tracker* developed on top of the Tanda platform for the [Tanda Hackathon 2019](https://www.eventbrite.com.au/e/tanda-hackathon-tickets-73074805711), held on 25/26th October 2019.

## Business problem

Businesses struggle to track mobile asset allocation and accompanying inspection schedules using manual paper based processes. This can lead to assets getting lost or becoming unavailable due to excessive wear.

## Solution summary

When employees clock into a shift using the [Tanda Time Clock App](https://www.tanda.co/features/employee-time-clock-app/) there is a facility to ask them a question and have them select from multiple answers.

We decided to build a prototype based specifically around the management and tracking of vehicles, with potential applicability to the mining sector, or general company pool cars.

When clocking in, the employee is asked if they are taking a vehicle, and given the opportunity to select one based on it's numberplate. The vehicle is then marked in use and the employee marked as using it, for reporting in a management portal.

## Technical details

Our solution uses the *platform object* extensibility point available in the Tanda platform to define a vehicle. A *shift question* is used to present these vehicles to the employee.

Vehicles selected by *shift question* must be pushed onto the appropriate *platform object* as they are independent concepts within the Tanda platform. This is princially achieved by utilising a webhook defined on the *clockin.updated* event.

We built a nodejs backend to receive the webhook and process its payload, bridging these concepts, using the Tanda API. The start of a shift results in the selected vehicle being determined through calls to the *shift* resource, and an update to a *platform* resource marks the vehicle in use by the current user. End of shift triggers more calls to the *shift* and *platform* resources to mark the vehicle as available, and increment how long the vehicle has been in use, according to the shift length. 

As a convenience, the management portal uses the backend server as a facade over the Tanda platform, providing authentication and an API which combines information about vehicles and their last user.

The management portal is built using React and deployed as a static site.

No external database or persistence is required in the current architecture, but one could be introduced for caching or more detailed reporting.

## Potential expansion

* Create vehicles through the management portal and add them to the *shift question*
* Automatically remove vehicles from available options when they have reached the end of their service interval
* Only show vehicles which are available within the *Time Clock App*
* Only show vehicles close to the employees' location
