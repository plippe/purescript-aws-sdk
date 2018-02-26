

-- | <fullname>AWS Import/Export Service</fullname> AWS Import/Export accelerates transferring large amounts of data between the AWS cloud and portable storage devices that you mail to us. AWS Import/Export transfers data directly onto and off of your storage devices using Amazon's high-speed internal network and bypassing the Internet. For large data sets, AWS Import/Export is often faster than Internet transfer and more cost effective than upgrading your connectivity.
module AWS.ImportExport where

import Control.Monad.Aff (Aff)
import Data.Foreign.NullOrUndefined (NullOrUndefined)
import Data.Map (Map)
import Data.Unit (Unit, unit)

import AWS.Request as AWS

serviceName = "ImportExport" :: String


-- | This operation cancels a specified job. Only the job owner can cancel it. The operation fails if the job has already started or is complete.
cancelJob :: forall eff. CancelJobInput -> Aff (err :: AWS.RequestError | eff) CancelJobOutput
cancelJob = AWS.request serviceName "CancelJob" 


-- | This operation initiates the process of scheduling an upload or download of your data. You include in the request a manifest that describes the data transfer specifics. The response to the request includes a job ID, which you can use in other operations, a signature that you use to identify your storage device, and the address where you should ship your storage device.
createJob :: forall eff. CreateJobInput -> Aff (err :: AWS.RequestError | eff) CreateJobOutput
createJob = AWS.request serviceName "CreateJob" 


-- | This operation generates a pre-paid UPS shipping label that you will use to ship your device to AWS for processing.
getShippingLabel :: forall eff. GetShippingLabelInput -> Aff (err :: AWS.RequestError | eff) GetShippingLabelOutput
getShippingLabel = AWS.request serviceName "GetShippingLabel" 


-- | This operation returns information about a job, including where the job is in the processing pipeline, the status of the results, and the signature value associated with the job. You can only return information about jobs you own.
getStatus :: forall eff. GetStatusInput -> Aff (err :: AWS.RequestError | eff) GetStatusOutput
getStatus = AWS.request serviceName "GetStatus" 


-- | This operation returns the jobs associated with the requester. AWS Import/Export lists the jobs in reverse chronological order based on the date of creation. For example if Job Test1 was created 2009Dec30 and Test2 was created 2010Feb05, the ListJobs operation would return Test2 followed by Test1.
listJobs :: forall eff. ListJobsInput -> Aff (err :: AWS.RequestError | eff) ListJobsOutput
listJobs = AWS.request serviceName "ListJobs" 


-- | You use this operation to change the parameters specified in the original manifest file by supplying a new manifest file. The manifest file attached to this request replaces the original manifest file. You can only use the operation after a CreateJob request but before the data transfer starts and you can only use it on jobs you own.
updateJob :: forall eff. UpdateJobInput -> Aff (err :: AWS.RequestError | eff) UpdateJobOutput
updateJob = AWS.request serviceName "UpdateJob" 


-- | Specifies the version of the client tool.
newtype APIVersion = APIVersion String


-- | A discrete item that contains the description and URL of an artifact (such as a PDF).
newtype Artifact = Artifact 
  { "Description" :: NullOrUndefined (Description)
  , "URL" :: NullOrUndefined (URL)
  }


-- | A collection of artifacts.
newtype ArtifactList = ArtifactList (Array Artifact)


-- | The account specified does not have the appropriate bucket permissions.
newtype BucketPermissionException = BucketPermissionException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | Input structure for the CancelJob operation.
newtype CancelJobInput = CancelJobInput 
  { "JobId" :: (JobId)
  , "APIVersion" :: NullOrUndefined (APIVersion)
  }


-- | Output structure for the CancelJob operation.
newtype CancelJobOutput = CancelJobOutput 
  { "Success" :: NullOrUndefined (Success)
  }


-- | The specified job ID has been canceled and is no longer valid.
newtype CanceledJobIdException = CanceledJobIdException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | Name of the shipping company. This value is included when the LocationCode is "Returned".
newtype Carrier = Carrier String


-- | Input structure for the CreateJob operation.
newtype CreateJobInput = CreateJobInput 
  { "JobType" :: (JobType)
  , "Manifest" :: (Manifest)
  , "ManifestAddendum" :: NullOrUndefined (ManifestAddendum)
  , "ValidateOnly" :: (ValidateOnly)
  , "APIVersion" :: NullOrUndefined (APIVersion)
  }


-- | Output structure for the CreateJob operation.
newtype CreateJobOutput = CreateJobOutput 
  { "JobId" :: NullOrUndefined (JobId)
  , "JobType" :: NullOrUndefined (JobType)
  , "Signature" :: NullOrUndefined (Signature)
  , "SignatureFileContents" :: NullOrUndefined (SignatureFileContents)
  , "WarningMessage" :: NullOrUndefined (WarningMessage)
  , "ArtifactList" :: NullOrUndefined (ArtifactList)
  }


-- | Each account can create only a certain number of jobs per day. If you need to create more than this, please contact awsimportexport@amazon.com to explain your particular use case.
newtype CreateJobQuotaExceededException = CreateJobQuotaExceededException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | Timestamp of the CreateJob request in ISO8601 date format. For example "2010-03-28T20:27:35Z".
newtype CreationDate = CreationDate Number


-- | The last manifest submitted, which will be used to process the job.
newtype CurrentManifest = CurrentManifest String


-- | The associated description for this object.
newtype Description = Description String


-- | Number of errors. We return this value when the ProgressCode is Success or SuccessWithErrors.
newtype ErrorCount = ErrorCount Int


-- | The human-readable description of a particular error.
newtype ErrorMessage = ErrorMessage String


-- | Indicates that the specified job has expired out of the system.
newtype ExpiredJobIdException = ExpiredJobIdException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


newtype GenericString = GenericString String


newtype GetShippingLabelInput = GetShippingLabelInput 
  { "JobIds'" :: (JobIdList)
  , "Name'" :: NullOrUndefined (Name')
  , "Company'" :: NullOrUndefined (Company')
  , "PhoneNumber'" :: NullOrUndefined (PhoneNumber')
  , "Country'" :: NullOrUndefined (Country')
  , "StateOrProvince'" :: NullOrUndefined (StateOrProvince')
  , "City'" :: NullOrUndefined (City')
  , "PostalCode'" :: NullOrUndefined (PostalCode')
  , "Street1'" :: NullOrUndefined (Street1')
  , "Street2'" :: NullOrUndefined (Street2')
  , "Street3'" :: NullOrUndefined (Street3')
  , "APIVersion" :: NullOrUndefined (APIVersion)
  }


newtype GetShippingLabelOutput = GetShippingLabelOutput 
  { "ShippingLabelURL" :: NullOrUndefined (GenericString)
  , "Warning" :: NullOrUndefined (GenericString)
  }


-- | Input structure for the GetStatus operation.
newtype GetStatusInput = GetStatusInput 
  { "JobId" :: (JobId)
  , "APIVersion" :: NullOrUndefined (APIVersion)
  }


-- | Output structure for the GetStatus operation.
newtype GetStatusOutput = GetStatusOutput 
  { "JobId" :: NullOrUndefined (JobId)
  , "JobType" :: NullOrUndefined (JobType)
  , "LocationCode" :: NullOrUndefined (LocationCode)
  , "LocationMessage" :: NullOrUndefined (LocationMessage)
  , "ProgressCode" :: NullOrUndefined (ProgressCode)
  , "ProgressMessage" :: NullOrUndefined (ProgressMessage)
  , "Carrier" :: NullOrUndefined (Carrier)
  , "TrackingNumber" :: NullOrUndefined (TrackingNumber)
  , "LogBucket" :: NullOrUndefined (LogBucket)
  , "LogKey" :: NullOrUndefined (LogKey)
  , "ErrorCount" :: NullOrUndefined (ErrorCount)
  , "Signature" :: NullOrUndefined (Signature)
  , "SignatureFileContents" :: NullOrUndefined (Signature)
  , "CurrentManifest" :: NullOrUndefined (CurrentManifest)
  , "CreationDate" :: NullOrUndefined (CreationDate)
  , "ArtifactList" :: NullOrUndefined (ArtifactList)
  }


-- | The AWS Access Key ID specified in the request did not match the manifest's accessKeyId value. The manifest and the request authentication must use the same AWS Access Key ID.
newtype InvalidAccessKeyIdException = InvalidAccessKeyIdException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | The address specified in the manifest is invalid.
newtype InvalidAddressException = InvalidAddressException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | One or more customs parameters was invalid. Please correct and resubmit.
newtype InvalidCustomsException = InvalidCustomsException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | File system specified in export manifest is invalid.
newtype InvalidFileSystemException = InvalidFileSystemException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | The JOBID was missing, not found, or not associated with the AWS account.
newtype InvalidJobIdException = InvalidJobIdException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | One or more manifest fields was invalid. Please correct and resubmit.
newtype InvalidManifestFieldException = InvalidManifestFieldException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | One or more parameters had an invalid value.
newtype InvalidParameterException = InvalidParameterException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | The client tool version is invalid.
newtype InvalidVersionException = InvalidVersionException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | Indicates whether the job was canceled.
newtype IsCanceled = IsCanceled Boolean


-- | Indicates whether the list of jobs was truncated. If true, then call ListJobs again using the last JobId element as the marker.
newtype IsTruncated = IsTruncated Boolean


-- | Representation of a job returned by the ListJobs operation.
newtype Job = Job 
  { "JobId" :: NullOrUndefined (JobId)
  , "CreationDate" :: NullOrUndefined (CreationDate)
  , "IsCanceled" :: NullOrUndefined (IsCanceled)
  , "JobType" :: NullOrUndefined (JobType)
  }


-- | A unique identifier which refers to a particular job.
newtype JobId = JobId String


newtype JobIdList = JobIdList (Array GenericString)


-- | Specifies whether the job to initiate is an import or export job.
newtype JobType = JobType String


-- | A list container for Jobs returned by the ListJobs operation.
newtype JobsList = JobsList (Array Job)


-- | Input structure for the ListJobs operation.
newtype ListJobsInput = ListJobsInput 
  { "MaxJobs" :: NullOrUndefined (MaxJobs)
  , "Marker" :: NullOrUndefined (Marker)
  , "APIVersion" :: NullOrUndefined (APIVersion)
  }


-- | Output structure for the ListJobs operation.
newtype ListJobsOutput = ListJobsOutput 
  { "Jobs" :: NullOrUndefined (JobsList)
  , "IsTruncated" :: NullOrUndefined (IsTruncated)
  }


-- | A token representing the location of the storage device, such as "AtAWS".
newtype LocationCode = LocationCode String


-- | A more human readable form of the physical location of the storage device.
newtype LocationMessage = LocationMessage String


-- | Amazon S3 bucket for user logs.
newtype LogBucket = LogBucket String


-- | The key where the user logs were stored.
newtype LogKey = LogKey String


-- | Your manifest is not well-formed.
newtype MalformedManifestException = MalformedManifestException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | The UTF-8 encoded text of the manifest file.
newtype Manifest = Manifest String


-- | For internal use only.
newtype ManifestAddendum = ManifestAddendum String


-- | Specifies the JOBID to start after when listing the jobs created with your account. AWS Import/Export lists your jobs in reverse chronological order. See MaxJobs.
newtype Marker = Marker String


-- | Sets the maximum number of jobs returned in the response. If there are additional jobs that were not returned because MaxJobs was exceeded, the response contains &lt;IsTruncated&gt;true&lt;/IsTruncated&gt;. To return the additional jobs, see Marker.
newtype MaxJobs = MaxJobs Int


-- | One or more required customs parameters was missing from the manifest.
newtype MissingCustomsException = MissingCustomsException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | One or more required fields were missing from the manifest file. Please correct and resubmit.
newtype MissingManifestFieldException = MissingManifestFieldException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | One or more required parameters was missing from the request.
newtype MissingParameterException = MissingParameterException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | Your manifest file contained buckets from multiple regions. A job is restricted to buckets from one region. Please correct and resubmit.
newtype MultipleRegionsException = MultipleRegionsException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | The specified bucket does not exist. Create the specified bucket or change the manifest's bucket, exportBucket, or logBucket field to a bucket that the account, as specified by the manifest's Access Key ID, has write permissions to.
newtype NoSuchBucketException = NoSuchBucketException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | A token representing the state of the job, such as "Started".
newtype ProgressCode = ProgressCode String


-- | A more human readable form of the job status.
newtype ProgressMessage = ProgressMessage String


-- | An encrypted code used to authenticate the request and response, for example, "DV+TpDfx1/TdSE9ktyK9k/bDTVI=". Only use this value is you want to create the signature file yourself. Generally you should use the SignatureFileContents value.
newtype Signature = Signature String


-- | The actual text of the SIGNATURE file to be written to disk.
newtype SignatureFileContents = SignatureFileContents String


-- | Specifies whether (true) or not (false) AWS Import/Export updated your job.
newtype Success = Success Boolean


-- | The shipping tracking number assigned by AWS Import/Export to the storage device when it's returned to you. We return this value when the LocationCode is "Returned".
newtype TrackingNumber = TrackingNumber String


-- | The URL for a given Artifact.
newtype URL = URL String


-- | AWS Import/Export cannot cancel the job
newtype UnableToCancelJobIdException = UnableToCancelJobIdException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | AWS Import/Export cannot update the job
newtype UnableToUpdateJobIdException = UnableToUpdateJobIdException 
  { "Message'" :: NullOrUndefined (ErrorMessage)
  }


-- | Input structure for the UpateJob operation.
newtype UpdateJobInput = UpdateJobInput 
  { "JobId" :: (JobId)
  , "Manifest" :: (Manifest)
  , "JobType" :: (JobType)
  , "ValidateOnly" :: (ValidateOnly)
  , "APIVersion" :: NullOrUndefined (APIVersion)
  }


-- | Output structure for the UpateJob operation.
newtype UpdateJobOutput = UpdateJobOutput 
  { "Success" :: NullOrUndefined (Success)
  , "WarningMessage" :: NullOrUndefined (WarningMessage)
  , "ArtifactList" :: NullOrUndefined (ArtifactList)
  }


-- | Validate the manifest and parameter values in the request but do not actually create a job.
newtype ValidateOnly = ValidateOnly Boolean


-- | An optional message notifying you of non-fatal issues with the job, such as use of an incompatible Amazon S3 bucket name.
newtype WarningMessage = WarningMessage String


-- | Specifies the name of your city for the return address.
newtype City' = City' String


-- | Specifies the name of the company that will ship this package.
newtype Company' = Company' String


-- | Specifies the name of your country for the return address.
newtype Country' = Country' String


-- | Specifies the name of the person responsible for shipping this package.
newtype Name' = Name' String


-- | Specifies the phone number of the person responsible for shipping this package.
newtype PhoneNumber' = PhoneNumber' String


-- | Specifies the postal code for the return address.
newtype PostalCode' = PostalCode' String


-- | Specifies the name of your state or your province for the return address.
newtype StateOrProvince' = StateOrProvince' String


-- | Specifies the first part of the street address for the return address, for example 1234 Main Street.
newtype Street1' = Street1' String


-- | Specifies the optional second part of the street address for the return address, for example Suite 100.
newtype Street2' = Street2' String


-- | Specifies the optional third part of the street address for the return address, for example c/o Jane Doe.
newtype Street3' = Street3' String
