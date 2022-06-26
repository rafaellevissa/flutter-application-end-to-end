import { FireStoreServiceInterface } from "Contracts/firebase";
import { initializeApp, FirebaseApp } from "firebase/app";
import { getFirestore, Firestore } from "firebase/firestore";
import { collection, addDoc, DocumentReference } from "firebase/firestore";

class FireStoreService implements FireStoreServiceInterface {
  private app: FirebaseApp;
  private firestore: Firestore;

  constructor() {
    this.app = initializeApp({
      projectId: process.env.FIREBASE_PROJECT_ID,
      apiKey: process.env.FIREBASE_API_KEY,
      appId: process.env.FIREBASE_APP_ID
    });

    this.firestore = getFirestore(this.app);
  }

  async createDocument(
    collectionName: string,
    data: any
  ): Promise<DocumentReference<any>> {
    return addDoc(
      collection(this.firestore, collectionName),
      data
    );
  }

  async createSubCollection(
    parentCollectionName: string,
    parentCollectionId: string,
    collectionName: string,
    data: any
  ) {
    await addDoc(
      collection(
        this.firestore,
        parentCollectionName,
        parentCollectionId,
        collectionName
      ),
      data
    )
  }
}

export default FireStoreService;