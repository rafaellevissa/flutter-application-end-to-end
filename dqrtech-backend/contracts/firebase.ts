import type { DocumentReference } from "firebase/firestore";

export interface FireStoreServiceInterface {
  createSubCollection(
    parentCollectionName: string,
    parentCollectionId: string,
    collectionName: string,
    data: any
  ): Promise<void>

  createDocument(
    collectionName: string,
    data: any
  ): Promise<DocumentReference<any>>
}
